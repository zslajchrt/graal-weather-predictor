tempInCity <- .fastr.interop.import('tempInCity')

library(maps)

cities <- world.cities[1:10*3100,c("name","lat")]
cities$temperature <- sapply(cities$name, function(x) tempInCity(x))

model <- lm(temperature~lat, data=cities)

latitude <- function(city) { 
	res <- world.cities[match(city, world.cities[[1]]), c("name","lat")]
	res$lat[1] 
}

predictTemp <- function (city) { 
	latit <- latitude(city)
	m <- data.frame(name=city, lat=latit)
	res <- predict(model, newdata=m)
	res[1]
}
	
realTemp <- function(city) {
	tempInCity(city)
}

.fastr.interop.export('predictTemp', predictTemp)
.fastr.interop.export('realTemp', realTemp)