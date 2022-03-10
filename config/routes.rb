Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/weather/:cityId', to: 'weather#send_weather_for_twitter', as: :weather
end
