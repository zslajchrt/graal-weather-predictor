require 'openweather2'

Openweather2.configure do |config| 
	config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
	config.apikey = 'dd7073d18e3085d0300b6678615d904d'
end

def tempInCity(name) 
	weather = Openweather2.get_weather(city: Truffle::Interop.from_java_string(name), units: 'metric')
	weather.temperature; 
end

Truffle::Interop.export('tempInCity', method(:tempInCity))