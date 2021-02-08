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
    @dates = get_dates(@five_days_result)
    @temps = get_temps(@five_days_result)
  end

  def get_five_days_result(response_list)
    five_days_result = []
    (0..4).to_a.each do |i|
      five_days_result.push(response_list[i * 8])
    end
    five_days_result
  end
  
  def get_dates(five_days_result)
    dates_with_time = []
    days = []
    five_days_result.each_with_index do |result|
      dates_with_time.push(result["dt_txt"])
    end
    dates_with_time
    
    dates_with_time.each do |dates|
      days.push(dates.split(" ")[0])
    end
    days
  end

  def get_temps(five_days_result)
    temps = []
    five_days_result.each do |result|
      temps.push(result["main"]["temp"])
    end
    temps
  end

  def convert_to_f(temp)
    (((temp - 273.15) * 9 / 5) + 32).to_i
  end

  def convert_to_c(temp)
    (temp - 273.15).to_i
  end
end

