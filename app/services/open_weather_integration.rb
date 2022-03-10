class OpenWeatherIntegration

  def initialize
    @client = OpenWeather::Client.new(
      api_key: ENV['OPEN_WEATHER_API_KEY']
    )
  end

  def get_weather(city_id)
    begin
      get_current_city_lat_and_long(city_id)
      response = @client.one_call(lat: @lat, lon: @lon, exclude: ['minutely', 'hourly'], units: 'metric')
      get_formatted_response(response)
    rescue => e
      false
    end
  end

  private

  def get_current_city_lat_and_long(city_id)
    response = @client.current_city_id(city_id)
    @lat     = response.coord.lat
    @lon     = response.coord.lon
    @city    = response.name
  end

  def get_formatted_response(response)
    actual_weather   = response.current
    first_prevision  = response.daily[1]
    second_prevision = response.daily[2]
    third_prevision  = response.daily[3]
    four_prevision   = response.daily[4]
    five_prevision   = response.daily[5]

    actual_weather.temp.to_s + '°C and '+ actual_weather.weather.first.description + ' in '+ @city + ' in ' +
      DateTime.parse(actual_weather.dt.to_s).strftime("%d/%m/%Y") +
      '. Average of temperature for the next few days: '+ first_prevision.temp.day.to_s + '°C em ' +
      DateTime.parse(first_prevision.dt.to_s).strftime("%d/%m/%Y") + ', '+ second_prevision.temp.day.to_s + '°C in ' +
      DateTime.parse(second_prevision.dt.to_s).strftime("%d/%m/%Y") + ', '+ third_prevision.temp.day.to_s + '°C in ' +
      DateTime.parse(third_prevision.dt.to_s).strftime("%d/%m/%Y") + ', '+ four_prevision.temp.day.to_s + '°C in ' +
      DateTime.parse(four_prevision.dt.to_s).strftime("%d/%m/%Y") + ' and '+ five_prevision.temp.day.to_s + '°C in ' +
      DateTime.parse(five_prevision.dt.to_s).strftime("%d/%m/%Y")
  end
end
