class ScreensController < ApplicationController
  def index
    
  end
  
  def show
    searched_city = params.require(:city)
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast?q=#{searched_city}&appid=" + ENV["WEATHER_API_KEY"])
    @city = response.parsed_response["city"]["name"]
    @weather_now = response.parsed_response["list"][0]["weather"][0]["main"]
    @weather_description = response.parsed_response["list"][0]["weather"][0]["description"]
  end
end

