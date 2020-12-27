class CLI

def call
Scraper.new.get_all_topics
  puts "Welcome to NutritionFacts"
  start
end

def start
  puts ""
  puts "Please type in the topic you would like to learn more?"
  input = gets.strip.chomp

  print_restaurants(input)

  puts ""
  puts "What restaurant would you like more information on?"
  input = gets.strip

  restaurant = WorldsBestRestaurants::Restaurant.find(input.to_i)

  print_restaurant(restaurant)

  puts ""
  puts "Would you like to see another restaurant? Enter Y or N"

  input = gets.strip.downcase
  if input == "y"
    start
  elsif input == "n"
    puts ""
    puts "Thank you! Have a great day!"
    exit
  else
    puts ""
    puts "I don't understand that answer."
    start
  end
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
