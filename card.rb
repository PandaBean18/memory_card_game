class Card
    attr_reader :sym, :orientation
    def initialize(sym)
        @sym = sym 
        @orientation = "down"
    end 

    def hide
        @orientation = "down"
    end

    def reveal
        @orientation = "up"
    end

end