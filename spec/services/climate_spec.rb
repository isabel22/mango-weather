require 'spec_helper'

describe MangoWeather::Climate do
  let(:client) do
    instance_double(
      OpenWeather::Client,
      current_weather: { name: 'Guatemala' },
      current_city_id: { id: 3595528 },
      current_cities_id: {
        list: [{ name: 'Guatemala' }, { name: 'Berlin' }]
      },
      one_call: { list: [] }
    )
  end

  before do
    allow(OpenWeather::Client).to receive(:new).and_return(client)
  end

  describe 'weather_by_city_name' do
    subject { described_class.weather_by_city_name(city_name: 'Republic of Guatemala, GT') }

    it 'calls the method weather_by_city_name with the parameters' do
      expect(described_class).to receive(:weather_by_city_name).with(city_name: 'Republic of Guatemala, GT')

      subject
    end
  end

  describe 'weather_by_city_id' do
    subject { described_class.weather_by_city_id(city_id: 3595528) }

    it 'calls the method weather_by_city_id with the specific id' do
      expect(described_class).to receive(:weather_by_city_id).with(city_id: 3595528)

      subject
    end
  end

  describe 'weather_for_cities' do
    subject { described_class.weather_for_cities(cities_array: [3595528, 2950159]) }

    it 'calls the method weather_for_cities with the specific ids' do
      expect(described_class).to receive(:weather_for_cities).with(cities_array: [3595528, 2950159])

      subject
    end
  end

  describe 'forecast' do
    subject { described_class.forecast(longitude: -90.25, latitude: 15.5) }

    it 'calls the method forecast with the specific latitude and longitude' do
      expect(described_class).to receive(:forecast).with(longitude: -90.25, latitude: 15.5)

      subject
    end
  end
end
