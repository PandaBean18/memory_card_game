require_relative "card.rb"
class Board
    attr_reader :num, :cards, :createcard
    def initialize(num)
        @num = num
        @occupied = []
        @cards = Hash.new
    end

    def grid  
        grid = Array.new(num) {Array.new(num, "\s")}
        grid[0][0] = " "
        grid[0][1..-1] = (1...num).to_a
        grid.each.with_index do |x, i|
            if i > 0 
                x[0] = i
            end
        end
        $grid = grid
    end

    def print_grid 
        $grid.each do |sub|
            puts sub.join("\s")
        end
    end

    def render
        render = Marshal.load(Marshal.dump($grid))
        @cards.each do |k, v|
            if v[1].orientation == "down"
                render[v[0][0]][v[0][1]] = "\s"
            else
                render[v[0][0]][v[0][1]] = k[0].to_sym
            end
        end
        render.each do |sub|
            puts sub.join("\s")
        end
    end            

    def populate(letter) 
        i = 0
        if num.even?
            @occupied << [(num / 2), (num / 2)]
            
        end

        while i < 2
            x = []
            x << rand(1...num)
            x << rand(1...num)
            if @occupied.include?(x)
                redo
            else 
                $grid[x[0]][x[1]] = letter
                @occupied << x
                @cards[letter.to_s + i.to_s] = [x, Card.new(letter)]
            end
            i += 1
        end
        
    end

    def placer 
        i = 0 
        available_letters = ("A".."Z").to_a
        while i < ((num - 1) * (num - 1)) / 2
            letter = available_letters.sample
            available_letters.delete_at(available_letters.index(letter))
            self.populate(letter.to_sym)
            i += 1
        end
    end

    def [](posx, posy)
        return $grid[posx][posy]
    end

    def valid(pos1, pos2)
        return self[pos1[0], pos1[1]] == self[pos2[0], pos2[1]]
    end

    def won?
        if @cards.values.any? {|x| x[1].orientation == "down"}
            false
        else
            true
        end
    end

    def reveal(pos)
        self.cards.each do |k, v|
            if v.include?(pos)
                v[1].reveal
            end
        end
    end

    def hide(pos1, pos2)
        self.cards.values.each do |subarr|
            if subarr[0] == pos1 || subarr[0] == pos2
                subarr[1].hide
            end
        end
    end
end

class String
    def to_a
        array = self.split(" ")
        arr = []
        array.each do |string|
            if string.include?(",")
                string.split(",").each {|x| arr << x.to_i}
        
            else
                arr << string.to_i
            end
        end
        return arr
    end
end
