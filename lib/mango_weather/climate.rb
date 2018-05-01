require 'open_weather'

module MangoWeather
  class Climate

    def self.weather_by_city_name(city_name)
      # city_name in the following pattern: "city, country ISO"
      # e.g.: "Berlin, DE"
      OpenWeather::Current.city(city_name, self.options)
    end

    def self.weather_by_city_id(city_id)
      # List of city ID city.list.json.gz can be downloaded here:
      # http://bulk.openweathermap.org/sample/
      OpenWeather::Current.city_id(city_id, self.options)
    end

    def self.weather_for_cities(cities_array)
      # List of city ID city.list.json.gz can be downloaded here:
      # http://bulk.openweathermap.org/sample/
      OpenWeather::Current.cities(cities_array, self.options)
    end

    def self.forecast_by_city_name(city_name, days = 3)
      OpenWeather::Forecast.city(city_name, self.options(days))
    end

    def self.forecast_by_city_id(city_id, days = 3)
      OpenWeather::Forecast.city_id(city_id, self.options(days))
    end

    private

    def self.options(days = nil)
      api_key = SECRETS["defaults"]["open_weather_map"]
      @options = {units: "metric", APPID: api_key}
      @options[:cnt] = days if days.present?

      @options
    end
  end
end
