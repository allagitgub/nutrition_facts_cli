require_relative 'topic_video'

class NutritionTopic
  attr_accessor :name, :url, :doctors_note, :list_of_videos

  @doc = nil
  @@all = Hash.new
  @@popular_tipics = []
  def initialize(name, url)
    @name = name
    @url = url
  end

  def self.all
    @@all
  end

  def self.create_and_save_popular_topics(a_element)
    self.create_and_save_topic_from_a_element(a_element, @@popular_tipics)
    @@popular_tipics.each do |topic|
      puts topic.name
    end
  end

  def self.create_and_save_all_topics(a_element, letter)
    letter_list = @@all[letter]
    if(letter_list == nil)
      letter_list = []
    end
    self.create_and_save_topic_from_a_element(a_element, letter_list)
    puts "letter_list after create and save" + letter
    puts letter_list.count
    @@all[letter] = letter_list
    letter_list.each do |topic|
      #puts topic.name
    end
  end

  def self.create_and_save_topic_from_a_element(a_element, store)
    a_element.each do |item|
      topic = NutritionTopic.new(item["title"], item["href"])
      store << topic
    end
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def list_of_videos
    puts "list of videos"
    @list_of_videos ||= get_list_of_videos
  end

  def doctors_note
    puts "doctors_note"
    @doctors_note ||= get_doctors_note
  end

  def get_list_of_videos
    puts "calling get_list_of_videos "+self.url
    list = []
    doc.css(".topic-videos").css(".container").css(".list-unstyled").css('a').each do |item|
      video_topic = TopicVideo.new(name, item["title"], item["href"])
      video_topic.doctors_note
      list << video_topic
    end
    list
  end

  def get_doctors_note
  end

  def self.lookup_topic_info_by_letter(topic_name, letter)
    letter_list = @@all[letter.capitalize]
    lookup_topic_info_for_list(topic_name, letter_list)
  end

  def self.lookup_topic_info(topic_name)
    Scraper.lookup_topic_info_for_list(topic_name, @@popular)
  end

  def self.lookup_topic_info_for_list(topic_name, list)
    this_topic = list.find do |topic| topic.name == topic_name
    end
    this_topic.list_of_videos
  end

end
