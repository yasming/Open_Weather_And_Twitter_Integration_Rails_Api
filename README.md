# Open Weather and Tiwitter Integration

This project is an API that integrates with open weather: https://openweathermap.org/ and twitter https://twitter.com/home, when the user send a request to the endpoint: weather/{city_id} , with a valid city id from open weather, it sends the weather as a commit in tweeter 

## Prerequisites

```
Ruby 2.7.3
```

```
Twitter app: https://developer.twitter.com/en/portal/projects-and-apps
```

### How to run project's locally

```
cp .env.example .env (and populate .env with the right credentials from twitter and open weather)
```

```
bundle install
```

```
rails server
```


## How to consume the project routes: 


- Get weather from open weather and publish on Twitter


```
POST localhost:3000/weather/2643743
```

```
Response: 
```

```
{
    "message": "The weather preview were commented on twitter"
}
```
