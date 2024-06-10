import SwiftUI

struct WeatherView: View {
    var weather: WeatherData
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name).bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light)
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                
                Spacer()
                
                VStack(){
                    HStack{
                        VStack(spacing:20){
                            
                            Image(systemName: weatherIcon(for: weather.weather[0].icon)).font(.system(size: 40))
                            
                            Text(weather.weather[0].main)
                            
                        }.frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble()+"°").font(.system(size: 100)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding()
                        
                    }
                    
                    Spacer().frame(height: 80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).padding()
            
            VStack{
                Spacer()
                
                VStack(alignment: .leading,spacing: 20){
                    
                    Text("Weather Now")
                        .bold()
                        .padding(.bottom)
                    
                    HStack{
                        WeatherRow(logo: "thermometer", name: "Min Temp", value: weather.main.tempMin.roundDouble() + "°")
                        
                        Spacer()
                        
                        WeatherRow(logo: "thermometer", name: "Max Temp", value: weather.main.tempMax.roundDouble() + "°")
                    }
                    HStack{
                        WeatherRow(logo: "wind", name: "Wind Speed", value: weather.wind.speed.roundDouble() + "m/s")
                        
                        Spacer()
                        
                        WeatherRow(logo: "humidity", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                    }
                    
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
            
        }.edgesIgnoringSafeArea(.bottom)
            .background(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

func weatherIcon(for iconCode: String) -> String {
    let weatherIcons: [String: String] = [
        "01d": "sun.max",
        "01n": "moon",
        "02d": "cloud.sun",
        "02n": "cloud.moon",
        "03d": "cloud",
        "03n": "cloud",
        "04d": "cloud.fill",
        "04n": "cloud.fill",
        "09d": "cloud.drizzle",
        "09n": "cloud.drizzle",
        "10d": "cloud.sun.rain",
        "10n": "cloud.moon.rain",
        "11d": "cloud.bolt.rain",
        "11n": "cloud.bolt.rain",
        "13d": "cloud.snow",
        "13n": "cloud.snow",
        "50d": "cloud.fog",
        "50n": "cloud.fog"
    ]
    
    return weatherIcons[iconCode] ?? "questionmark"
}

#Preview {
    WeatherView(weather: previewData)
}
