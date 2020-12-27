class NutritionTopic
  attr_accessor :name, :url, :list_of_videos, :doctors_note

  @doc = nil
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
    @@popular_tipics.each do |topic|
      puts topic.name
    end
  end

  def self.create_and_save_all_topics(a_element)
    self.create_and_save_topic_from_a_element(a_element, @@all)
    @@all.each do |topic|
      puts topic.name
    end
  end

  def self.create_and_save_topic_from_a_element(a_element, store)
    a_element.each do |item|
      topic = NutritionTopic.new(item["title"], item["href"])
      store << topic
      #topic.list_of_videos
    end
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def list_of_videos
    @list_of_videos ||= get_list_of_videos
    # @description ||= doc.xpath("//div[@class='c-8 nl nt']/p[3]").text
  end

  def get_list_of_videos
    list = []
    doc.css("container").css('a').each do |item|
      list << item["href"]
      puts item["href"]
    end
    list
  end

  def self.lookup_topic_info(topic_name)
    this_topic = @@all.find do |topic| topic.name == topic_name
    end
    this_topic.list_of_videos.each do |video|
      puts video
    end
  end
end
