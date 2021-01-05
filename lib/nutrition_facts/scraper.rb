class NutritionFacts::Scraper
  #attr_accessor :page
 @@page = nil
 ALPHABET = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
  def self.get_page
    if(@@page == nil)
      @@page = Nokogiri::HTML(open("https://nutritionfacts.org/topics"))
    end
      @@page
  end

  def self.scrape_popular_topics
    NutritionFacts::NutritionFact.create_and_save_popular_topics(self.get_page.css(".topics-trending").css("a"))
  end

  def self.scrape_topics_alphabetically
    ALPHABET.each do |letter|
      doc = self.get_page.css('div#column_'+"#{letter}")
      NutritionFacts::NutritionFact.create_and_save_all_topics(doc.css('ul.list-unstyled').css('a'), letter)
    end
  end

  def self.get_all_topics
    NutritionFacts::Scraper.scrape_topics_alphabetically
  end

  def self.get_popular_topics
    NutritionFacts::Scraper.scrape_popular_topics
  end

end
