require 'cuba'
require 'cuba/safe'

module OpenWeatherMap
  class Current
    def self.city
end

Dir.glob('views/*.rb').each do |file|
  require_relative file
end

Dir.glob('lib/*.rb').each do |file|
  require_relative file
end

Cuba.plugin Cuba::Safe
Cuba.use Rack::Static, root: File.dirname(__FILE__) + '/static/'

Cuba.define do
  on get, root do
    res.write Index.new.render
  end
  on param('location') do |location|
    weather_info = OpenWeatherMap::Current.city(
      location,
      APPID: ENV['API_KEY'],
      units: 'metric'
    )
    res.write Weather.new(
      weather_info['name'],
      weather_info['weather'][0]['main'],
      weather_info['main']['temp'],
      weather_info['units'],
      weather_info['main']['humidity'],
      weather_info['wind']['speed']
    ).render
  end
end
