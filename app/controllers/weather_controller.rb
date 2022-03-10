class WeatherController < ActionController::API
  OPEN_WEATHER_INTEGRATION_CLASS = OpenWeatherIntegration.new

  def send_weather_for_twitter
    weather_preview = OPEN_WEATHER_INTEGRATION_CLASS.get_weather(weather_params)
    if weather_preview === false
      render json: {message: 'Weather could not be found'}, status: :unprocessable_entity
      return
    end

    commented = comment_in_twitter(weather_preview)

    if commented == false
      render json: {message: 'Comment in twitter could to be done'}, status: :unprocessable_entity
      return
    end

    render json: {message: 'The weather preview were commented on twitter'}, status: :ok
  end

  private

  def weather_params
    params.require(:city_id)
  end

  def comment_in_twitter(actual_temp)
    TwitterIntegration.new.comment(actual_temp)
  end

end
