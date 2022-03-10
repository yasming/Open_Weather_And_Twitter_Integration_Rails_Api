require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest

  test "it should return an error message if city not found" do
    OpenWeatherIntegration.any_instance.stubs(:get_weather).returns(false)
    post '/weather/1'

    assert_response :unprocessable_entity
    assert_equal 'Weather could not be found', JSON.parse(response.body)['message']
  end

  test "it should return an success message when the city is found and twitter comment were done" do
    OpenWeatherIntegration.any_instance.stubs(:get_weather).returns('The weather preview were commented on twitter')
    TwitterIntegration.any_instance.stubs(:comment).returns(true)
    post '/weather/1'

    assert_response :success
    assert_equal 'The weather preview were commented on twitter', JSON.parse(response.body)['message']
  end

  test "it should return an serror message if the weather could not be sent for twitter" do
    OpenWeatherIntegration.any_instance.stubs(:get_weather).returns('The weather preview were commented on twitter')
    TwitterIntegration.any_instance.stubs(:comment).returns(false)
    post '/weather/1'

    assert_response :unprocessable_entity
    assert_equal 'Comment in twitter could to be done', JSON.parse(response.body)['message']
  end


end
