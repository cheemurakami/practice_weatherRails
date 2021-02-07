class ScreensController < ApplicationController
  def index
    
  end
  
  def show
    @searched_city = params.require(:city)
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast?q=#{@searched_city}&appid=" + ENV["WEATHER_API_KEY"])
  end
end

