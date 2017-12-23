require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './topic.rb'

class TopicScraper

  def get_page
    Nokogiri::HTML(open("https://www.biblestudytools.com/topical-verses/"))
  end

  def get_topics
    self.get_page.css(".list-group-item")
  end

  def make_topics

    self.get_topics.each do |post|
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
      puts ""
    end
  end
end
TopicScraper.new.get_page
TopicScraper.new.print_topics
