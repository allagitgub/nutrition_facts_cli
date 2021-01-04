class NutritionFacts::TopicVideo

  attr_accessor :topic_name, :video_name, :doctors_note, :url, :vide_url

  @doc

  def initialize(topic_name, video_name, url)
    @topic_name = topic_name
    @video_name = video_name
    @url = url
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def doctors_note
    @doctors_note ||= get_doctors_note
  end

  def get_doctors_note
    note = nil
    self.doc.css(".doctors-note").css("p").each do |paragraph|
      if note == nil
        note = paragraph.text
      else
        note = note + paragraph
      end
      note + '\n'
    end
    note
  end

  def video_url
    @video_url ||= get_video_url
  end

  def get_video_url
    self.doc.css(".youtube-video")[0]["src"]
  end
end
