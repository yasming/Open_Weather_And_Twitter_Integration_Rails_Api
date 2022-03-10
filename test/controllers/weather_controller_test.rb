require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest

  test "it should return an error message if city not found" do
    OpenWeatherIntegration.any_instance.stubs(:get_weather).returns(false)
    post '/weather/1'

    assert_response :unprocessable_entity
    assert_equal 'Weather could not be found', JSON.parse(response.body)['message']
  end

  test "it should return an success message when the city is found" do
    OpenWeatherIntegration.any_instance.stubs(:get_weather).returns("14.69°C and overcast clouds in London in 10/03/2022. Average of temperature for the next few days: 9.91°C em 11/03/2022, 11.29°C in 12/03/2022, 10.88°C in 13/03/2022, 12.6°C in 14/03/2022 e 11.69°C in 15/03/2022")
    post '/weather/1'

    assert_response :success
    assert_equal '14.69°C and overcast clouds in London in 10/03/2022. Average of temperature for the next few days: 9.91°C em 11/03/2022, 11.29°C in 12/03/2022, 10.88°C in 13/03/2022, 12.6°C in 14/03/2022 e 11.69°C in 15/03/2022', JSON.parse(response.body)['message']
  end

end
