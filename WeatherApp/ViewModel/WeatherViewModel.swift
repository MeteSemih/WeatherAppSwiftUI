//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Mete Semih Özlek on 15.10.2025.
//

import Foundation
import Combine

class WeatherViewModel : ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading  = false
    @Published var errorMessage: String?
    @Published var searchCityName : String = ""
    
    private let weatherService = WeatherService()
    
    func fetchWeather (city:String) {
        
        Task{
            isLoading = true
            errorMessage = nil
            
            do
            {
                let weatherData = try await weatherService.fetchWeather(city: city)
                self.weather = weatherData
            }catch {
                self.errorMessage = "Hata\(error.localizedDescription)"
            
                
            }
            
            isLoading = false
            
            
        }
        
    }
    
    func fetchWeatherByLocation(long:Double,lat:Double) {
        
        Task {
            isLoading = true
            errorMessage = nil
            
            do{
                let locationData = try await weatherService.fetchCoordinate(long: long, lat: lat)
                self.weather = locationData
                
            }catch{
                self.errorMessage =  "Location error \(error.localizedDescription)"
            }
            
            isLoading = false
        }
        
    }
    
    
    
    /// 
    
}
