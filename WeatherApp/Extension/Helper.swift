//
//  Helper.swift
//  WeatherApp
//
//  Created by Mete Semih Özlek on 15.10.2025.
//

import Foundation

extension WeatherViewModel {
    
    var temperatureString: String { // ✅ typo düzeltildi
        guard let temp = weather?.main.temp else { return "--" }
        return String(format: "%.0f°C", temp)
    }
    
    var cityName: String {
        weather?.name ?? "Şehir seçin"
    }
    
    var weatherDescription: String {
        weather?.weather.first?.description.capitalized ?? "" // ✅ ! kaldırıldı
    }
    
    var weatherIcon: String {
        weather?.weather.first?.icon ?? "01d"
    }
    
    var humidity: String {
        guard let humidity = weather?.main.humidity else { return "---" } // ✅ typo düzeltildi
        return "\(humidity)%"
    }
    
    var windSpeed: String {
        guard let speed = weather?.wind.speed else { return "---" }
        return String(format: "%.1f m/s", speed)
    }
}
