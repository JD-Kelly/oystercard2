class Oystercard

    CARD_LIMIT = 90

    attr_reader :balance
    #attr_accessor :in_journey

    def initialize
        @balance = 0
        @in_journey = false
    end

    def top_up(value)
        fail "Your oystercard has reached its limit of £#{CARD_LIMIT}" if limit?
        @balance += value
    end

    def deduct(value)
        @balance -= value
    end

    def touch_in
        @in_journey = true
    end

    def touch_out
        @in_journey = false
    end

    def in_journey?
        @in_journey
    end

    private

    def limit?
        @balance >= CARD_LIMIT ? true : false
    end

    
end