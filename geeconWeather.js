fs = require('fs');

console.log("Initializing Openweather");
var weatherInitScript = fs.readFileSync("geeconWeatherInit.rb", "utf8");
Interop.eval("application/x-ruby", weatherInitScript);

console.log("Preparing weather model");
var weatherModelScript = fs.readFileSync("geeconWeatherModel.r", "utf8");
Interop.eval("application/x-r", weatherModelScript);

predictTemp = Interop.import('predictTemp');
realTemp = Interop.import('realTemp');

function jsonify(cityName, realTmp, predictedTmp) {
	return JSON.stringify({
		city: cityName, 
		real: realTmp, 
		predicted: predictedTmp
	});
}

console.log("Starting server...");
var http = require("http");
var server = http.createServer(function (inp, out) {
	var cityName = inp.url.substring(1);
	out.end(jsonify(cityName, realTemp(cityName), predictTemp(cityName)));
});
server.listen(8080);
