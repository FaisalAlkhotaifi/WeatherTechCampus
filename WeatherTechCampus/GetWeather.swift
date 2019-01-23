//
//  GetWeather.swift
//  WeatherTechCampus
//
//  Created by TechCampus on 1/20/19.
//  Copyright © 2019 TechCampus. All rights reserved.
//

import Foundation

protocol WeatherGetterDelegate {
    func didGetWeather(weather: Weather)
    func didNotGetWeather(error: Error)
}

class GetWeather {
        
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "fa5645db79c2791fc44cd9466103e5ff"
    
    private var delegate: WeatherGetterDelegate
    
    init(delegate: WeatherGetterDelegate) {
        self.delegate = delegate
    }
    
    func getWeatherByCity(city: String) {
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        getWeather(weatherRequestUrl: weatherRequestURL)
    }
    
    func getWeather(weatherRequestUrl: URL) {
        
        // The data task retrieves the data.
        let dataTask = URLSession.shared.dataTask(with: weatherRequestUrl) { (data, response, error) in
            if error != nil {
                // An error occurred while trying to get data from the server.
                self.delegate.didNotGetWeather(error: error!)
            }
            else {
                //Success, We got data from the server!
                do {
                    // Try to convert that data into a Swift dictionary
                    let weatherData = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    
                    // converted the JSON-formatted weather data into a Swift dictionary.
                    
                    //now use that dictionary to initialize a Weather struct.
                    let weather = Weather(weatherData: weatherData)
                    
                    // notify the view controller, will use it to display the weather to the user.
                    self.delegate.didGetWeather(weather: weather)
                }
                catch let jsonError as NSError {
                    // An error occurred while trying to convert the data into a Swift dictionary.
                    self.delegate.didNotGetWeather(error: jsonError)
                }
            }
        }
        // The data task is set up.
        dataTask.resume()
    }
  
}
