# frozen_string_literal: true

OpenWeather::Client.configure do |config|
  config.api_key = ENV.fetch('OPEN_WEATHER_API_KEY', nil)
  config.user_agent = 'OpenWeather Ruby Client/1.0'
  config.lang = 'en'
  config.units = 'metric'
end
