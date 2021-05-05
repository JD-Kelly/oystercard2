class Oystercard

    MAX_LIMIT = 90
    MIN_LIMIT = 1
    MIN_FARE = 1

    attr_reader :balance
    attr_reader :station

    def initialize
        @balance = 0
        @station = nil
    end

    def top_up(value)
        fail "Your oystercard has reached its limit of £#{MAX_LIMIT}" if limit?
        @balance += value
    end

    def touch_in(station)
        fail "Your oystercard has insufficient funds" if minimum?
        @station = station
    end

    def touch_out
        @station = nil
        deduct(MIN_FARE)
    end

    def in_journey?
        !!station
    end

    private

    def limit?
        @balance >= MAX_LIMIT
    end

    def minimum? 
        @balance <= MIN_LIMIT
    end

    def deduct(value)
        @balance -= value
    end
end