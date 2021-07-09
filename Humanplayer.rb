require_relative "board.rb"
class HumanPlayer
    
    def initialize
        @tried = []
        @size = 0
    end

    def prompt
        puts "Please type the size of the grid (between 2 and 53). If the number is odd, the middle square will be empty.\n\n"
        @size = gets.chomp.to_i
        while @size < 2 || @size > 53 
            puts "b r u h. **Between 2 and 53** smfh\n\n"
            @size = gets.chomp.to_i
        end
        $board = Board.new(@size + 1)
        $board.grid
        $board.placer
        $board.print_grid
        sleep(2)
        system("clear")
    end

    def get_input
        puts "Please put a position that you would like to flip. Example '1, 2'\n\n"
        $coordinate1 = gets.chomp.to_a
        
        if @size.odd?
            while $coordinate1 == [(@size + 1) / 2, (@size + 1) / 2]
                puts "Invalid input. Please try again"
                $coordinate1 = gets.chomp.to_a
            end
        end

        while @tried.include?($coordinate1)
            puts "bruh moment. you have already used that position ;-;. enter a different position\n\n"
            $coordinate1 = gets.chomp.to_a
        end

        $board.reveal($coordinate1)
        $board.render

        puts "Please put a position that you would like to flip. Example '1, 2'\n\n"

        $coordinate2 = gets.chomp.to_a

        if @size.odd?
            while $coordinate2 == [(@size + 1) / 2, (@size + 1) / 2]
                puts "Invalid input. Please try again\n\n"
                $coordinate2 = gets.chomp.to_a
            end
        end

        while @tried.include?($coordinate2) || $coordinate1 == $coordinate2
            puts "bruh moment. you have already used that position ._. . Enter a different position\n\n"
            $coordinate2 = gets.chomp.to_a
        end

        $board.reveal($coordinate2)

        if $board.valid($coordinate1, $coordinate2) 
            puts "its a match!!\n\n"
            $board.render
            @tried << $coordinate1
            @tried << $coordinate2
        elsif !$board.valid($coordinate1, $coordinate2)
            puts "Its not a match. F. Try again.\n\n"
            $board.render
            sleep(2)
            system("clear")
            $board.hide($coordinate1, $coordinate2)
            $board.render
        end
    end
end