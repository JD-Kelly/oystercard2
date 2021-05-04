require 'oystercard'

describe Oystercard do
    
    # In order to use public transport
    # As a customer
    # I want money on my card
    it 'returns a new oystercard with a balance of 0' do
        oystercard = Oystercard.new
        expect(oystercard.balance).to eq(0)
    end

    # In order to keep using public transport
    # As a customer
    # I want to add money to my card
    describe '#top_up' do
        it { is_expected.to respond_to(:top_up).with(1).argument }
        it 'tops up an oystercard with the value provided' do
            expect { subject.top_up(10) }.to change { subject.balance }.by 10
        end
    end

end