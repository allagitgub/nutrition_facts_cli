require_relative 'nutrition_fact'
require_relative 'scraper'

class CLI

def call
Scraper.new.get_all_topics
  puts "Welcome to NutritionFacts"
  start
end

def valid_choice?(input)
  input == 'popular' || Scraper::ALPHABET.include?(input.capitalize)
end

def start
  puts "Which Nutrition topic would you like to explore?"
  puts "Please type in 'popular' or a letter of the alphabet (E.g.: 'a') to see all popular topics or all topics starting with the letter you typed"
  puts ""
  choice = gets.chomp.downcase
  while !valid_choice?(choice)
    puts "Your input is invalid, please try again"
    choice = gets.chomp.downcase
  end
  if choice == "popular"
    Scraper.get_popular_topics
    NutritionTopic.display_popular_topics
  else
      Scraper.get_all_topics
      NutritionTopic.display_topics_by_letter(choice.capitalize)
  end

  puts ""
  puts "Please type in a topic from above list for more information"
  input = gets.strip.chomp
  puts ""
  puts "Retrieving information..."
  list_of_topic_videos = []
  if choice == "popular"
    list_of_topic_videos = NutritionTopic.lookup_topic_info(input)
  else
    letter = input[0].capitalize
    list_of_topic_videos = NutritionTopic.lookup_topic_info_by_letter(input, letter)
  end
  puts ""
  puts "Which of the following subtopics, would you like to get more information on:"
  puts ""
  list_of_topic_videos.each do |video|
    puts "      - "+video.video_name
  end
  puts ""
  input = gets.chomp
  selected_video = list_of_topic_videos.find { |video| video.video_name = input}
  puts ""
  puts "===================================================================================================================="
  puts "Video Name: "
  puts ""+selected_video.video_name
  puts ""
  puts "Video youtube url: "
  puts ""+selected_video.video_url
  puts ""
  puts "Video Doctor's Note: "
  puts ""+selected_video.doctors_note
  puts "===================================================================================================================="
end

def print_restaurant(restaurant)
  puts ""
  puts "----------- #{restaurant.name} - #{restaurant.position} -----------"
  puts ""
  puts "#{restaurant.intro_quote}"
  puts "Location:           #{restaurant.location}"
  puts "Head Chef:          #{restaurant.head_chef}"
  puts "Contact:            #{restaurant.contact}"
  puts "Phone:             #{restaurant.phone}"
  puts "Website:            #{restaurant.website_url}"

  puts ""
  puts "---------------Description--------------"
  puts ""
  puts "#{restaurant.description}"
  puts ""

  puts ""
  puts "---------------About the Food--------------"
  puts ""
  puts "#{restaurant.food_style}"
  puts ""
end

def print_restaurants(from_number)
  puts ""
  puts "---------- Restaurants #{from_number} - #{from_number+9} ----------"
  puts ""
  WorldsBestRestaurants::Restaurant.all[from_number-1, 10].each.with_index(from_number) do |restaurant, index|
    puts "#{index}. #{restaurant.name} - #{restaurant.location}"
  end
end
end

CLI.new.start
