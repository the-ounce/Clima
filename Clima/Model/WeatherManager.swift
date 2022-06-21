//
//  WeatherManager.swift
//  Clima
//
//  Created by Никита Гавриленко on 20.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?APPID=272d89cfe1c79920a1eb2a186ae21a7c&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)

            let weatherId = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: weatherId, cityName: name, temp: temp)
            
            print(weather.tempString)
        } catch {
            print(error)
        }
    }
    
    

}
