require 'mustache'

class Weather < Mustache
  self.template_path = File.dirname(__FILE__) + '/../templates'
  Wind = Struct.new(:speed, :direction)
  attr_reader :name, :description, :temperature, :units, :humidity, :wind
  def initialize(name, description, temperature, units, humidity, wind_speed, wind_direction)
    @name = name
    @description = description
    @temperature = temperature
    @units = units
    @humidity = humidity
    @wind = Wind.new(wind_speed, a2d(wind_direction))
  end
  def a2d(degrees)
    # Convert wind direction in degrees to a direction (eg. north-west)
    index = ((degrees % 360) / 45) % 8
    names = ["north","north-east","east","south-east","south","south-west","west","north-west"]
    names[index]
  end
end
