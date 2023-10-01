require 'open-weather-ruby-client'

module MangoWeather
  class Climate
    # List of city ID city.list.json.gz can be downloaded here:
    # http://bulk.openweathermap.org/sample/
    def self.weather_by_city_name(city_name:)
      new.weather_by_city_name(city_name)
    end

    def self.weather_by_city_id(city_id:)
      new.weather_by_city_id(city_id)
    end

    def self.weather_for_cities(cities_array:)
      new.weather_for_cities(cities_array)
    end

    def self.forecast(latitude:, longitude:)
      new.forecast(latitude, longitude)
    end

    def initialize
      @client = OpenWeather::Client.new
    end

    def weather_by_city_name(city_name)
      client.current_weather(city: city_name)
    end

    def weather_by_city_id(city_id)
      client.current_city_id(city_id)
    end

    def weather_for_cities(cities_array)
      client.current_cities_id(cities_array)
    end

    def forecast(latitude, longitude)
      client.one_call(lat: latitude, lon: longitude)
    end

    private

    attr_reader :client
  end
end
