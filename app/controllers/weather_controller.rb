class WeatherController < ActionController::API
  OPEN_WEATHER_INTEGRATION_CLASS = OpenWeatherIntegration.new

  def send_weather_for_twitter
    actual_temp = OPEN_WEATHER_INTEGRATION_CLASS.get_weather(weather_params)
    if actual_temp === false
      render json: {message: 'Weather could not be found'}, status: :unprocessable_entity
      return
    end
    render json: {message: actual_temp}, status: :ok
  end

  private

  def weather_params
    params.require(:city_id)
  end
end
