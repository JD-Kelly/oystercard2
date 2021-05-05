require 'oystercard'

describe Oystercard do
    let(:station) {double :station}
    
    # In order to use public transport
    # As a customer
    # I want money on my card
    it 'returns a new oystercard with a balance of 0' do
        oystercard = Oystercard.new
        expect(oystercard.balance).to eq(0)
    end

    it 'creates a oystercard with and empty journey history' do
        expect(subject.journeys).to be_empty
    end

    describe '#top_up' do
    # In order to keep using public transport
    # As a customer
    # I want to add money to my card
        it { is_expected.to respond_to(:top_up).with(1).argument }

        it 'tops up an oystercard with the value provided' do
            expect { subject.top_up(10) }.to change { subject.balance }.by 10
        end
    
    # In order to protect my money from theft or loss
    # As a customer
    # I want a maximum limit (of £90) on my card
        it 'raises an error when the balance reaches £90' do
            maximum_balance = Oystercard::MAX_LIMIT
            subject.top_up(90)
            expect {subject.top_up(1) }.to raise_error("Your oystercard has reached its limit of £#{maximum_balance}")
        end
    end

    describe '#deduct' do
    # In order to pay for my journey
    # As a customer
    # I need my fare deducted from my card
        it 'reduces the balance on the oystercard when the card is used' do
            subject.top_up(10)
            expect { subject.send(:deduct, 10) }.to change { subject.balance }.by -10
        end
    end
    
    describe '#touch_in' do
    # In order to get through the barriers.
    # As a customer
    # I need to touch in and out.
        it 'changes the state of the oystercard to in use when touched in' do
            subject.top_up(10)
            subject.touch_in(station)
            expect(subject).to be_in_journey
        end

    # In order to pay for my journey
    # As a customer
    # I need to have the minimum amount (£1) for a single journey.
        it 'raises an error when the balance reaches £1' do
            expect { subject.touch_in(station) }.to raise_error("Your oystercard has insufficient funds")
        end

        it 'remembers station after touch_in' do 
            subject.top_up(10)
            subject.touch_in(station)
            expect(subject.station).to eq station
        end
        
    end

    describe '#touch_out' do
    # In order to get through the barriers.
    # As a customer
    # I need to touch in and out.
        it 'changes the state of the oystercard to NOT in use when touched out' do
            subject.top_up(10)
            subject.touch_in(station)
            subject.touch_out(station)
            expect(subject).not_to be_in_journey
        end

        it 'reduces the balance on the oystercard by MIN_FARE when the card is touch_out' do
            min_fare = Oystercard::MIN_FARE
            subject.top_up(10)
            subject.touch_in(station)
            expect { subject.touch_out(station) }.to change { subject.balance }.by -min_fare
        end

        it 'forgets station on touch_out' do 
            subject.top_up(10)
            subject.touch_in(station)
            subject.touch_out(station)
            expect(subject.station).to eq nil
        end
    end

    describe '#journey_history' do
        it 'returns the history of journeys travelled after touch_out' do
            subject.top_up(10)
            subject.touch_in(station)
            subject.touch_out(station)
            expect(subject.journeys).to eq([{entry: station, exit: station}])
        end
    end
end