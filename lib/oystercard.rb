
class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3

  attr_reader :balance, :journeys

  def initialize(set_balance = DEFAULT_BALANCE)
    @balance = set_balance
    @journeys = []
  end

  def start_journey(station)
    journey = {entry_station: station}
    @journeys << journey
  end

  def end_journey(station)
    if @journeys.empty? || !in_journey? # if they didn't touch in
      start_journey("No Touch-in.") # start a journey with a spoof name
      @journeys.last[:exit_station] = station
      # self.deduct(PENALTY_FARE)
      # charge penalty fare
    else
      @journeys.last[:exit_station] = station
      self.deduct(MINIMUM_FARE)
    end
  end

  def top_up(value)
    raise "Cannot top up, you exceeded the £#{MAXIMUM_BALANCE} maximum balance" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    return false if @journeys.empty? # lol
    !@journeys.last[:exit_station] # lolol
  end

end
