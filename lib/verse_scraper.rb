require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './verse.rb'

class VerseScraper

  def get_page
    #doc = Nokogiri::HTML(open("https://www.biblestudytools.com/1-john/5-5.html"))
    #title = doc.css("h1").text
    #description = doc.css(".verse-5").text
    #binding.pry
    Nokogiri::HTML(open("https://www.biblestudytools.com/1-john/5-5.html"))
  end

  def make_verse
    verse = Verse.new
    post = self.get_page
    verse.title = post.css("h1").text
    verse.description = post.css(".verse-5").text
    verse.save
  end

  def print_verse
    self.make_verse
    Verse.all.each do |verse|
      if verse.title != ""
        puts "Verse: #{verse.title}"
        puts "   #{verse.description}"
      else
        puts "ERROR"
      end
    end
  end
end
VerseScraper.new.print_verse
