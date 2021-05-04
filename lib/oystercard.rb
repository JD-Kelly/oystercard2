class Oystercard

    CARD_LIMIT = 90

    attr_reader :balance

    def initialize
        @balance = 0
    end

    def top_up(value)
        fail "Your oystercard has reached its limit of £#{CARD_LIMIT}" if limit?
        @balance = @balance + value
    end

    private

    def limit?
        @balance >= CARD_LIMIT ? true : false
    end
end