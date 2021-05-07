# frozen_string_literal: true

class Oystercard
  MAX_LIMIT = 90
  MIN_FARE = 1

  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(value)
    raise "Your oystercard has reached its limit of £#{MAX_LIMIT}" if limit?

    @balance += value
  end

  def touch_in(station)
    raise 'Your oystercard has insufficient funds' if minimum?

    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey.finish(station)
    record_journey
    deduct(@journey.fare)
    @journey = nil
  end

  def in_journey?
    if @journey.nil? || @journey.complete?
      false
    else
      true
    end
  end

  def record_journey
    @journeys << { entry: @journey.entry_station, exit: @journey.exit_station }
  end

  private

  def limit?
    @balance >= MAX_LIMIT
  end

  def minimum?
    @balance <= MIN_FARE
  end

  def deduct(value)
    @balance -= value
  end
end
