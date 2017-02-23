require 'oystercard'

describe Oystercard do

  it 'has a default balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'has an empty journey history to begin with' do
    expect(subject.journeys).to be_empty
  end

  describe '#journeys' do
    it 'holds an entry station when a journey has begun' do
      subject.start_journey("Kings Cross")
      expect(subject.journeys.last[:entry_station]).to eql "Kings Cross"
    end

    it 'stores an exit station when a journey finished' do
      subject.start_journey("Kings Cross")
      subject.end_journey("Angel")
      expect(subject.journeys.last[:exit_station]).to eql "Angel"
    end

  end

  describe '#start_journey' do
    it 'starts a journey' do
      subject.top_up(5)
      subject.start_journey("Kings Cross")
      expect(subject.journeys.last[:entry_station]).to eql "Kings Cross"
    end
  end

  describe '#end_journey' do
    it 'ends a journey' do
      subject.top_up(5)
      subject.start_journey("Kings Cross")
      subject.end_journey("Angel")
      expect(subject.journeys.last[:exit_station]).to eql "Angel"
    end

    it 'deducts the minimum fare' do
      subject.top_up(5)
      subject.start_journey("Kings Cross")
      expect {subject.end_journey("Angel")}.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
    end

    it "knows when you didn't touch in" do

    end

  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject.in_journey?).to be false
    end

    it "can be in a journey" do
      subject.start_journey("Kings Cross")
      expect(subject.in_journey?).to be true
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
