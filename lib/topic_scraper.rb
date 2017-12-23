require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './topic.rb'

class TopicScraper

  def get_page
    #doc = Nokogiri::HTML(open("https://www.biblestudytools.com/topical-verses/"))
    #title = doc.css(".xl-h3.list-group-item-heading").first.text
    #description = doc.css(".list-group-item").first.css("p").text
    #url = doc.css(".list-group-item").css("a").attribute("href").value
    #binding.pry
    Nokogiri::HTML(open("https://www.biblestudytools.com/topical-verses/"))
  end

  def get_topics
    self.get_page.css(".list-group-item")
  end

  def make_topics

    self.get_topics.each do |post|
      #binding.pry
        topic = Topic.new
        topic.title = post.css(".xl-h3.list-group-item-heading").text
        topic.description = post.css("p").text
        topic.url = post.css("a").attribute("href").value
        if topic.title != ""
        topic.save
      end
    end
  end

  def print_topics
    self.make_topics
    Topic.all.each do |topic|
      puts "Topic: #{topic.title}"
      puts "  Description: #{topic.description}"
      puts "  Link: #{topic.url}"
    end
  end
end
Scraper.new.get_page
Scraper.new.print_topics
