require 'nokogiri'
require 'open-uri'

require_relative 'nutrition_fact'

class Scraper
  #attr_accessor :page
 @@page = nil
  def self.get_page
    if(@@page == nil)
      @@page = Nokogiri::HTML(open("https://nutritionfacts.org/topics"))
    end
      @@page
  end

  def self.scrape_topics_list
    #puts self.get_page.css(".topics-trending")
     self.get_page.css(".topics-trending").css("a").each do |topic|
     puts topic["href"]
     puts topic["title"]
     NutritionTopic.new(topic["title"], topic["href"])
     end
     #puts self.get_page.css(".topics-trending")
  end
end

Scraper.scrape_topics_list
