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