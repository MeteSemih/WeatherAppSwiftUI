import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .cyan],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // 🔍 Arama Alanı
                    SearchBarView(cityName: $viewModel.searchCityName) {
                        viewModel.fetchWeather(city: viewModel.searchCityName)
                    }
                    
                    // 🔄 Yükleniyor göstergesi
                    if viewModel.isLoading {
                        ProgressView("Yükleniyor...")
                            .foregroundStyle(.white)
                    }
                    
                  
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    
                    if let weather = viewModel.weather {
                        VStack(spacing: 12) {
                            Text(weather.name)
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text(weather.weather.first?.description.capitalized ?? "")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.9))
                            
                            Text("\(weather.main.temp, specifier: "%.1f")°C")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundStyle(.white)
                            
                            HStack(spacing: 25) {
                                VStack {
                                    Text("Hissedilen")
                                        .font(.caption)
                                    Text("\(weather.main.feels_like)°")
                                        .font(.title3)
                                }
                                VStack {
                                    Text("Nem")
                                        .font(.caption)
                                    Text("%\(weather.main.humidity)")
                                        .font(.title3)
                                }
                                VStack {
                                    Text("Rüzgar")
                                        .font(.caption)
                                    Text("\(weather.wind.speed, specifier: "%.1f") m/s")
                                        .font(.title3)
                                }
                            }
                            .foregroundStyle(.white)
                            .padding(.top)
                        }
                        .padding()
                        .background(.white.opacity(0.15))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .transition(.opacity)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("WeatherApp")
        }
    }
}

#Preview {
    WeatherView()
}


