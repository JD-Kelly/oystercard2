# frozen_string_literal: true

require 'journey'

describe Journey do
  let(:station) { double(name: 'Victoria', zone: 1) }
  it 'expects a journey to be incomplete' do
    expect(subject).not_to be_complete
  end

  it 'deducts the penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when finishing a journey' do
    expect(subject.finish).to eq subject
  end

  context 'with an entry_station' do
    subject { described_class.new(station) }

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it 'deducts the penalty fare with no exit station' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    context 'with an exit station' do
      let(:station2) { double(name: 'Waterloo', zone: 1) }

      before do
        subject.finish(station2)
      end

      it 'Calculates a fare' do
        expect(subject.fare).to eq(1)
      end
    end
  end
end
