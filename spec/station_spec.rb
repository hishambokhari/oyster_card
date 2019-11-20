require 'station'

describe Station do
  station = Station.new(:name, :zone)

  it "responds to the name method" do
    expect(station.name).to eq :name
  end

  it "responds to the zone method" do
    expect(station.zone).to eq :zone
  end
end
