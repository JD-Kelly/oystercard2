require 'oystercard'

describe Oystercard do
    
    # In order to use public transport
    # As a customer
    # I want money on my card
    it 'returns a new oystercard with a balance of 0' do
        oystercard = Oystercard.new
        expect(oystercard.balance).to eq(0)
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
            expect { subject.deduct(10) }.to change { subject.balance }.by -10
        end
    end
    
    describe '#touch_in' do
    # In order to get through the barriers.
    # As a customer
    # I need to touch in and out.
        it 'changes the state of the oystercard to in use when touched in' do
            subject.top_up(10)
            subject.touch_in
            expect(subject).to be_in_journey
        end

        it 'raises an error when the balance reaches £1' do
            expect { subject.touch_in }.to raise_error("Your oystercard has insufficient funds")
        end
        
    end

    describe '#touch_out' do
    # In order to get through the barriers.
    # As a customer
    # I need to touch in and out.
        it 'changes the state of the oystercard to NOT in use when touched out' do
            subject.top_up(10)
            subject.touch_in
            subject.touch_out
            expect(subject).not_to be_in_journey
        end
    end

end