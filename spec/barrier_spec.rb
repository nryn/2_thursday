require 'barrier'

describe Barrier do
  subject(:barrier) {described_class.new("Kings Cross")}

  before(:each) do
    @card = Oystercard.new
  end

  it "should raise an error is no station is entered" do
    expect { Barrier.new() }.to raise_error(ArgumentError)
  end

  describe '#touch_in' do

    before(:each) do
      allow(@card).to receive(:balance).and_return 10
    end

    it "starts the oystercard's journey" do
      barrier.touch_in(@card)
      expect(@card.journeys).to_not be_empty
    end

    it "remembers the entry station" do
      barrier.touch_in(@card)
      expect(@card.journeys.last[:entry_station]).to eq barrier.station_name
    end

      context "when balance is below the minimum" do

        it "won't let a card touch in unless it has a minimum balance" do
          allow(@card).to receive(:balance).and_return 0
          expect{barrier.touch_in(@card)}.to raise_error "You must have a minimum balance of £#{Oystercard::MINIMUM_BALANCE}"
        end
      end
  end

  describe '#touch_out' do

    it "ends the oyster card's journey" do
      allow(@card).to receive(:balance).and_return 10
      Barrier.new("Faraway Station").touch_in(@card)
      barrier.touch_out(@card)
      expect(@card.journeys.last[:exit_station]).to eql barrier.station_name
    end

    it "deducts some money from the oystercard balance" do
      @card.top_up(10)
      Barrier.new("Faraway Station").touch_in(@card)
      expect {barrier.touch_out(@card)}.to change{@card.balance}.by -Oystercard::MINIMUM_FARE
    end


    it 'records the exit station' do
      allow(@card).to receive(:balance).and_return 10
      barrier.touch_in(@card)
      barrier.touch_out(@card)
      expect(@card.journeys.last[:exit_station]).to eql barrier.station_name
    end
  end
end
