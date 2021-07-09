#this is the main file that you need to run in the terminal. put all the other files in the same folder as this one
#the number of pairs will be the square of the size that you input. if it is an odd number, the middle square will be empty as the cards are present in pairs.

require_relative "board.rb"
require_relative "card.rb"
require_relative "Humanplayer.rb"
def ask_user
    humanPlayer = HumanPlayer.new
    humanPlayer.prompt
    while !$board.won?
        humanPlayer.get_input
    end
    
    puts "Congratulations!! you have guessed all the cards correctly!\n\n"
    
end

ask_user
