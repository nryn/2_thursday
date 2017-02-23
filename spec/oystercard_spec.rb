require 'oystercard'

describe Oystercard do

  it 'has a default balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#entry_station' do
    it 'is not a thing, to begin with' do
      expect(subject.entry_station).to be nil
    end
  end

  describe '#top_up' do

    it 'can top up oystercard with set amount' do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it 'raises an error if top up would increase balance over top up limit' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      error = "Cannot top up, you exceeded the £#{maximum_balance} maximum balance"
      expect{ subject.top_up(1) }.to raise_error error
    end

  end

  describe '#deduct' do

    it 'deducts amount from the balance' do
      subject.top_up(10)
      expect{ subject.deduct 3 }.to change{ subject.balance }.by -3
    end

  end

end
