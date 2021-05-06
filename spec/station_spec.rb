require 'station'

describe Station do
  subject {described_class.new("Shoreditch", 1)}

  it 'knows the station name' do
    expect(subject.name).to eq("Shoreditch")
  end

  it 'knows its zone' do                                                     
    expect(subject.zone).to eq(1)                                 
  end
end
