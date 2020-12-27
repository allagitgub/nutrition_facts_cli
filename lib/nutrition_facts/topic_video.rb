class TopicVideo

  attr_accessor :topic_name, :video_name, :doctors_note, :video_url

  def initialize(topic_name, video_name, video_url)
    @topic_name = topic_name
    @video_name = video_name
    @video_url = video_url
  end
end
