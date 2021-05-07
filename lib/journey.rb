# frozen_string_literal: true

class Journey
  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def complete?; end

  def fare
    if !@entry_station.nil? && @exit_station
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end

  def finish(station = nil)
    @exit_station = station
    self
  end
end
