require 'pry'

class NutritionFacts::NutritionFact
  attr_accessor :name, :url, :doctors_note, :list_of_videos

  @doc = nil
  @@all = Hash.new
  @@popular_topics = []
  def initialize(name, url)
    @name = name
    @url = url
  end

  def self.all
    @@all
  end

  def self.create_and_save_popular_topics(a_element)
    self.create_and_save_topic_from_a_element(a_element, @@popular_topics)
  end

  def self.create_and_save_all_topics(a_element, letter)
    letter_list = @@all[letter]
    if(letter_list == nil)
      letter_list = []
    end
    self.create_and_save_topic_from_a_element(a_element, letter_list)
    @@all[letter] = letter_list
  end

  def self.create_and_save_topic_from_a_element(a_element, store)
    a_element.each do |item|
      topic = self.new(item["title"], item["href"])
      store << topic
    end
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def list_of_videos
    @list_of_videos ||= get_list_of_videos
  end

  def doctors_note
    @doctors_note ||= get_doctors_note
  end

  def get_list_of_videos
    #list = []
    doc.css(".topic-videos").css(".container").css(".list-unstyled").css('a').map do |item|
      video_topic = NutritionFacts::TopicVideo.new(name, item["title"], item["href"])
      video_topic.doctors_note
      #list << video_topic
      video_topic
    end.sort_by {|obj| obj.video_name}
  end


  def get_doctors_note
  end

  def self.lookup_topic_info_by_letter(topic_name, letter)
    letter_list = @@all[letter.capitalize]
    lookup_topic_info_for_list(topic_name, letter_list)
  end

  def self.lookup_topic_info(topic_name)
    lookup_topic_info_for_list(topic_name, @@popular_topics)
  end

  def self.display_popular_topics
    @@popular_topics.each do |topic|
      puts "      - "+topic.name
    end
  end

  def self.display_topics_by_letter(letter)
    list_of_topics = @@all[letter]
    list_of_topics.each do |topic|
      puts "      - "+topic.name
    end
  end

  def self.lookup_topic_info_for_list(topic_name, list)
    this_topic = list.find do |topic| topic.name.downcase == topic_name.downcase
    end
    if(this_topic == nil)
      nil
    else
      this_topic.list_of_videos
    end
  end

end
