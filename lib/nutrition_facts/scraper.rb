
class Scraper
  attr_accessor :page

  def get_page
    if(self.page == nil)
      self.page = Nokogiri::HTML(open("https://nutritionfacts.org"))
    end
      self.page
  end

  def scrape_topics_list
     puts doc.css(".topics-trending").css(".col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-3").each do |topic|
       
     end
  end

  def make_restaurants
    scrape_restaurants_index.each do |r|
      WorldsBestRestaurants::Restaurant.new_from_index_page(r)
    end
  end
end
end
