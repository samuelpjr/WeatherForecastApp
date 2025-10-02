//
//  AdditionalDetailsView.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI

struct AdditionalDetailsView: View {
    
    @State var viewModel: DetailsWeatherViewModel
    
    init (viewModel: DetailsWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Additional Details")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
                .foregroundColor(.white)
            
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    DetailCell(icon: "wind", title: "Wind", value: viewModel.windSpeed)
                    DetailCell(icon: "humidity.fill", title: "Humidity", value: viewModel.humidity)
                }
                GridRow {
                    DetailCell(icon: "gauge.medium", title: "Pressure", value: viewModel.pressure)
                    DetailCell(icon: "eye.fill", title: "Visibility", value: viewModel.visibility)
                }
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

//#Preview {
//    AdditionalDetailsView()
//}
