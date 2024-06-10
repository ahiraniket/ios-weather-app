import Foundation
import CoreLocation

class WeatherManager{
    func getCurrentWeather (latitude: CLLocationDegrees, longitude:CLLocationDegrees) async throws -> WeatherData {
        let apiKey = "96e511787279a53c40eabe4a20143670"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else {
            fatalError("Missing URL")
        }
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for:urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error Fetching Weather Data")
        }
        
        let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
        
        return decodedData
    }
}


