class Oystercard

    MAX_LIMIT = 90
    MIN_LIMIT = 1


    attr_reader :balance
    #attr_accessor :in_journey

    def initialize
        @balance = 0
        @in_journey = false
    end

    def top_up(value)
        fail "Your oystercard has reached its limit of £#{MAX_LIMIT}" if limit?
        @balance += value
    end

    def deduct(value)
        @balance -= value
    end

    def touch_in
        fail "Your oystercard has insufficient funds" if minimum?
        @in_journey = true
    end

    def touch_out
        @in_journey = false
    end

    def in_journey?
        @in_journey
    end

     def minimum? 
        @balance <= MIN_LIMIT
     end

    private

    def limit?
        @balance >= MAX_LIMIT ? true : false
    end

    
end