class OpenWeatherMap
  require 'net/http'
  require 'uri'
  require 'json'

  def initialize(appid, units="metric")
    @appid = appid
    @units = units
  end

  def now(location)
    uri = URI.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{@appid}&units=#{@units}"
    )

    JSON.parse(Net::HTTP.get(uri))
  end

  def distill(body)
    body = JSON.parse(body)

    {
      temperature: body['main']['temp'],
      description: body['weather'][0]['main'],
      humidity: body['main']['humidity'],
      visibility: body['visibility'],
      pressure: body['main']['pressure'],
      wind: {
        speed: body['wind']['speed']
        direction: a2d(body['wind']['deg'])
      },
      clouds: res.clouds.all,
      name: res.name,
      units: res.units
    }
  end

  def a2d(deg)
    index = (deg / 45) % 16
    directions = ["north", "north-east", "east", "south-east", "south", "south-west", "west", "north-west"]
    directions[index]
  end
end
