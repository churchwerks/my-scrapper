require 'nokogiri'
require 'open-uri'
require 'pry'
#
require_relative './verse.rb'

class VerseScraper

  def get_page
    Nokogiri::HTML(open("https://www.biblestudytools.com/1-john/5-5.html"))
  end

  def make_verse
    verse = Verse.new
    post = self.get_page
    verse.title = post.css("h1").text
    verse.description = post.css("div.scripture div span:nth-child(2)").text.strip
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
VerseScraper.new.get_page
VerseScraper.new.print_verse
