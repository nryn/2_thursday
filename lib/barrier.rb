class Barrier

  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
  end

  def touch_in(oystercard)
    fail "You must have a minimum balance of £#{Oystercard::MINIMUM_BALANCE}" if oystercard.balance <= Oystercard::MINIMUM_BALANCE
    oystercard.start_journey(@station_name)
  end

  def touch_out(oystercard)
    oystercard.end_journey(@station_name)
  end

end
