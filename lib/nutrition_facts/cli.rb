require_relative 'nutrition_fact'
require_relative 'scraper'

class CLI

def call
Scraper.new.get_all_topics
  puts "Welcome to NutritionFacts"
  start
end

def start
  Scraper.get_all_topics
  puts ""
  puts "Please type in the topic you would like to learn more?"
  input = gets.strip.chomp
  NutritionTopic.lookup_topic_info(input)
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
