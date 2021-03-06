require 'spec_helper'

describe MangoWeather::Climate do
  describe 'weather_by_city_name' do
    it 'gets data of current weather for a specific city' do
      filepath = File.join(Rails.root + "spec/support/fixtures/weather_by_city_name.json")
      climate_data = File.open(filepath).read
      parsed_climate = JSON.parse(climate_data, :symbolize_names => true)

      app_id = SECRETS["defaults"]["open_weather_map"]
      stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=#{app_id}&q=,Republic%20of%20Guatemala,%20GT&units=metric").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'api.openweathermap.org',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: climate_data, headers: {})

      climate = MangoWeather::Climate.weather_by_city_name("Republic of Guatemala, GT")

      expect(climate["name"]).to eq(parsed_climate[:name])
      expect(climate["weather"].first["description"]).to eq(parsed_climate[:weather].first[:description])
      expect(climate["main"]["temp"]).to eq(parsed_climate[:main][:temp])
      expect(climate["clouds"]["all"]).to eq(parsed_climate[:clouds][:all])
    end
  end

  describe 'weather_by_city_id' do
    it 'gets data of current weather for a specific city' do
      filepath = File.join(Rails.root + "spec/support/fixtures/weather_by_city_id.json")
      climate_data = File.open(filepath).read
      parsed_climate = JSON.parse(climate_data, :symbolize_names => true)

      app_id = SECRETS["defaults"]["open_weather_map"]
      stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=#{app_id}&id=3595528&units=metric").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'api.openweathermap.org',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: climate_data, headers: {})

      climate = MangoWeather::Climate.weather_by_city_id(3595528)

      expect(climate["name"]).to eq(parsed_climate[:name])
      expect(climate["weather"].first["description"]).to eq(parsed_climate[:weather].first[:description])
      expect(climate["main"]["temp"]).to eq(parsed_climate[:main][:temp])
      expect(climate["clouds"]["all"]).to eq(parsed_climate[:clouds][:all])
    end
  end

  describe 'weather_for_cities' do
    it 'gets data of current weather for multiple cities' do
      filepath = File.join(Rails.root + "spec/support/fixtures/weather_for_cities.json")
      climate_data = File.open(filepath).read
      parsed_climate = JSON.parse(climate_data, :symbolize_names => true)

      app_id = SECRETS["defaults"]["open_weather_map"]
      stub_request(:get, "http://api.openweathermap.org/data/2.5/group?APPID=#{app_id}&id=3595528,2950159&units=metric").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'api.openweathermap.org',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: climate_data, headers: {})

      climate = MangoWeather::Climate.weather_for_cities([3595528, 2950159])

      expect(climate["cnt"]).to eq(parsed_climate[:cnt])
      expect(climate["list"].count).to eq(parsed_climate[:list].count)
      expect(climate["list"].first["weather"].first["description"]).to eq(
        parsed_climate[:list].first[:weather].first[:description]
      )
    end
  end

  describe 'forecast_by_city_name' do
    it 'gets the weather forecast for a specific city' do
      filepath = File.join(Rails.root + "spec/support/fixtures/forecast_by_city_name.json")
      climate_data = File.open(filepath).read
      parsed_climate = JSON.parse(climate_data, :symbolize_names => true)

      app_id = SECRETS["defaults"]["open_weather_map"]
      stub_request(:get, "http://api.openweathermap.org/data/2.5/forecast?APPID=#{app_id}&cnt=3&q=,Republic%20of%20Guatemala,%20GT&units=metric").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'api.openweathermap.org',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: climate_data, headers: {})

      climate = MangoWeather::Climate.forecast_by_city_name("Republic of Guatemala, GT")

      expect(climate["cnt"]).to eq(parsed_climate[:cnt])
      expect(climate["list"].count).to eq(parsed_climate[:list].count)
      expect(climate["list"].first["weather"].first["description"]).to eq(
        parsed_climate[:list].first[:weather].first[:description]
      )
    end
  end

  describe 'forecast_by_city_id' do
    it 'gets the weather forecast for a specific city_id' do
      filepath = File.join(Rails.root + "spec/support/fixtures/forecast_by_city_id.json")
      climate_data = File.open(filepath).read
      parsed_climate = JSON.parse(climate_data, :symbolize_names => true)

      app_id = SECRETS["defaults"]["open_weather_map"]
      stub_request(:get, "http://api.openweathermap.org/data/2.5/forecast?APPID=#{app_id}&cnt=3&id=3595528&units=metric").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'api.openweathermap.org',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: climate_data, headers: {})

      climate = MangoWeather::Climate.forecast_by_city_id(3595528)

      expect(climate["cnt"]).to eq(parsed_climate[:cnt])
      expect(climate["list"].count).to eq(parsed_climate[:list].count)
      expect(climate["list"].first["weather"].first["description"]).to eq(
        parsed_climate[:list].first[:weather].first[:description]
      )
    end
  end
end
