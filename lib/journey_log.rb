# frozen_string_literal: true

class JourneyLog
  attr_reader :journeys

  def initialize(journey_class:)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @journeys << @journey_class.new(entry_station: station)
  end
end
