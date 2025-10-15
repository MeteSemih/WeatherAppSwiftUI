//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mete Semih Özlek on 14.10.2025.
//

import Foundation

class WeatherService {
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "YOUR_KEY"

    func fetchWeather(city: String) async throws -> WeatherResponse {
        var components = URLComponents(string: baseUrl)! // ✅ var yaptık
        
        // ✅ Query items olarak ekledik
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "tr")
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
        return weatherResponse
    }

    func fetchCoordinate(long: Double, lat: Double) async throws -> WeatherResponse {
        var components = URLComponents(string: baseUrl)!
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(long)),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "tr")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
        
        return weatherResponse
    }
}
