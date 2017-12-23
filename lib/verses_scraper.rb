require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './verses.rb'

class VersesScraper

  def get_page
    doc = Nokogiri::HTML(open("https://www.biblestudytools.com/faith-bible-verses/"))
    title = doc.css(".xl-h3.list-group-item-heading").first.text
    description = doc.css(".list-group-item").first.css("p").text
    url = doc.css(".list-group-item").css("a").attribute("href").value
    binding.pry
    #Nokogiri::HTML(open("https://www.biblestudytools.com/faith-bible-verses/"))
  end

  def get_verses
    self.get_page.css(".list-group-item")
  end

  def make_verses

    self.get_verses.each do |post|
      #binding.pry
        verses = Verses.new
        verses.title = post.css(".xl-h3.list-group-item-heading").text
        verses.description = post.css("p").text
        verses.url = post.css("a").attribute("href").value
        if verses.title != ""
        verses.save
      end
    end
  end

  def print_verses
    self.make_verses
    Verses.all.each do |verse|
      puts "Verse: #{verse.title}"
      puts "  Description: #{verse.description}"
      puts "  Link: #{verse.url}"
    end
  end
end
Scraper.new.get_page
Scraper.new.print_verses
