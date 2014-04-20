require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(101)
@@number = settings.secret_number
@@number_of_guesses = 5
@@cheat_mode = false

def show_secret_number
  "<p>You've unlocked Cheat Mode!The SECRET NUMBER #{@@number}.</p>"
end

def reset_game
  @@number = rand(101)
  @@number_of_guesses = 5
  @@cheat_mode = false
end

def set_color(message)
  return '#990000' if /way/=~message.downcase
  return '#009900' if /right/=~message.downcase
  return '#CC3300'
end

def check_guess(guess)
  case
  when guess == @@number
    reset_game
    "You got it right!"
  when guess >= (@@number + 5)
    @@number_of_guesses -= 1
    "Way too high!"
  when guess > @@number
    @@number_of_guesses -= 1
    "Too high!"
  when guess <= (@@number - 5)
    @@number_of_guesses -= 1
    "Way too low!"
  else
    @@number_of_guesses -= 1
    message = "Too low!"
  end
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  reset_game if @@number_of_guesses == 0
  @@cheat_mode = params["cheat"]
  erb :index, :locals => {:number => @@number, :message => message, :number_of_guesses => @@number_of_guesses, :cheat_mode => @@cheat_mode }
end
