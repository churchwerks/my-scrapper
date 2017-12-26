require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './verses.rb'

class VersesScraper

  def get_page(topic= )
    Nokogiri::HTML(open("https://www.biblestudytools.com/topical-verses/#{topic}-bible-verses/"))
  end

  def get_verses
    self.get_page.css(".col-xs-12.col-md-12")
  end

  def make_verses
    self.get_verses.each do |post|
        verses = Verses.new
        verses.title = post.css(".list-group-item-heading").text
        verses.url = post.css("a").attribute("href").value
        if verses.title != ""
        verses.save
      end
    end
  end

  def print_verses
    self.make_verses
    Verses.all.each do |verse|
      if verse.title != ""
        puts "Verse: #{verse.title}"
        puts "  Link: #{verse.url}"
      else
        puts "ERROR"
      end
    end
  end
end
VersesScraper.new.get_page
VersesScraper.new.print_verses
