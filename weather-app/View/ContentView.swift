import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: WeatherData?
    
    var body: some View {
        VStack{
            
            if let location = locationManager.location{
                if let weather = weather {
                    WeatherView(weather: weather)
                }
                else{
                    LoadingView().task {
                        do{
                            try await weather = weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        }catch{
                            print("Error getting weather: \(error)")
                        }
                    }
                }
            }else{
                if locationManager.isLoading{
                    LoadingView()
                }
                else
                {
                    WelcomeView().environmentObject(locationManager)
                }
            }
            
            
        }
        .background(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews:PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
