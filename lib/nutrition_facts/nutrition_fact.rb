class NutritionTopic
  attr_accessor :name, :url

  @@all = []
  @@popular_tipics = []
  def initialize(name, url)
    @name = name
    @url = url
  end

  def self.all
    @@all
  end

  def self.create_and_save_popular_topics(a_element)
    self.create_ant_save_topic_from_a_element(a_element_item, @@popular_tipics)
  end

  def self.create_and_save_all_topics(a_element)
    self.create_ant_save_topic_from_a_element(a_element_item, @@all)
  end

  def self.create_ant_save_topic_from_a_element(a_element_item, store)
    a_element.each do |item|
      topic = NutritionTopic.new(topic["title"], topic["href"])
      store << topic
    end
  end
end
