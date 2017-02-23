
class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3

  attr_reader :balance
  attr_accessor :entry_station

  def initialize(set_balance = DEFAULT_BALANCE)
    @balance = set_balance
  end

  def top_up(value)
    raise "Cannot top up, you exceeded the £#{MAXIMUM_BALANCE} maximum balance" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    !!@entry_station
  end

end
