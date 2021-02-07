class ScreensController < ApplicationController
  def index
    
  end
  
  def show
    searched_city = params.require(:city)
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast?q=#{searched_city}&appid=" + ENV["WEATHER_API_KEY"])
    parsed_response = response.parsed_response
    
    @city = parsed_response["city"]["name"]
    all_results = parsed_response["list"]
    @weather_now = all_results[0]["weather"][0]["main"]
    @weather_description = all_results[0]["weather"][0]["description"]
    @five_days_result = get_five_days_result(all_results)
  end

  def get_five_days_result(response_list)
    five_days_result = []
    (0..4).to_a.each do |i|
      five_days_result.push(response_list[i * 8])
    end
    five_days_result
  end
end

