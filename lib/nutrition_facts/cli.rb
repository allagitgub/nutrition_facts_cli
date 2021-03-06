class NutritionFacts::CLI

def call
NutritionFacts::Scraper.new.get_all_topics
  puts "Welcome to NutritionFacts"
  start
end

def valid_choice?(input)
  input == 'popular' || NutritionFacts::Scraper::ALPHABET.include?(input.capitalize)
end

def start
  continue = "yes"
  while continue == "yes"
    puts "******************************************************************************************************************************************************************************************"
    puts "Which Nutrition topic would you like to explore?"
    puts "Please type in 'popular' to see all popular topics or a letter of the alphabet (E.g.: 'a') to see all topics starting with the letter you typed"
    puts "******************************************************************************************************************************************************************************************"
    puts ""
    choice = gets.chomp.downcase
    while !valid_choice?(choice)
      puts "Your input is invalid, please try again"
      choice = gets.chomp.downcase
    end
    puts ""
    puts "Retrieving information..."
    puts ""
    if choice == "popular"
      NutritionFacts::Scraper.get_popular_topics
      NutritionFacts::NutritionFact.display_popular_topics
    else
        NutritionFacts::Scraper.get_all_topics
        NutritionFacts::NutritionFact.display_topics_by_letter(choice.capitalize)
    end

    list_of_topic_videos = []
    while list_of_topic_videos == nil || list_of_topic_videos.count == 0
      puts ""
      puts "******************************************************************************************************************************************************************************************"
      puts "Please type in a topic from above list for more information"
      puts "******************************************************************************************************************************************************************************************"
      input = gets.strip.chomp
      puts "Retrieving information..."
      if choice == "popular"
        list_of_topic_videos = NutritionFacts::NutritionFact.lookup_topic_info(input)
      else
        letter = input[0].capitalize
        list_of_topic_videos = NutritionFacts::NutritionFact.lookup_topic_info_by_letter(input, letter)
      end
      if list_of_topic_videos == nil || list_of_topic_videos.count == 0
        puts ""
        puts "Invalid Input"
      end
    end

    puts ""
    list_of_topic_videos.each do |video|
      puts "      - "+video.video_name
    end

    selected_video = nil
    while selected_video == nil
      puts ""
      puts "******************************************************************************************************************************************************************************************"
      puts "Which of the above subtopics, would you like to get more information on:"
      puts "******************************************************************************************************************************************************************************************"
      puts ""
      input = gets.chomp
      selected_video = list_of_topic_videos.find { |video| video.video_name.downcase == input.downcase}
      if(selected_video == nil)
        puts ""
        puts "Invalid Input"
      end
    end
    puts ""
    puts "=========================================================================================================================================================================================="
    puts "Video Name: "
    puts ""+selected_video.video_name
    puts ""
    puts "Video youtube url: "
    puts ""+selected_video.video_url
    puts ""
    puts "Video Doctor's Note: "
    puts ""+selected_video.doctors_note
    puts "=========================================================================================================================================================================================="

    puts "******************************************************************************************************************************************************************************************"
    puts "Would like to continue exploring, please type in yes or no"
    puts "******************************************************************************************************************************************************************************************"
    continue = gets.chomp.downcase
    puts ""
  end
end


end
