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
            
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let stringData = String(data: safeData, encoding: .utf8)
            print(stringData!)
        }
    }
}
