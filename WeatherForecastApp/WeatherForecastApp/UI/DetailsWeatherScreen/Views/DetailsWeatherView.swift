//
//  DetailsWeatherView.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI
import Charts

struct DetailsWeatherView: View {
    
    @State var viewModel: DetailsWeatherViewModel
    @Binding var cityLocation: (lat: Double, lon: Double)?
    
    init(viewModel: DetailsWeatherViewModel, cityLocation: Binding<(lat: Double, lon: Double)?>) {
        self.viewModel = viewModel
        _cityLocation = cityLocation
    }
    
    var body: some View {
        ZStack {
            GradientBackground()
            switch viewModel.viewState {
            case .loading:
                LoadingIndicatorView()
            case .loaded:
                ScrollView {
                    VStack(spacing: 20) {
                        MainDetailsCardView(viewModel: viewModel)
                        
                        HourlyForecastChart(viewModel: viewModel)
                        
                        AdditionalDetailsView(viewModel: viewModel)
                    }
                }
            case .error(_):
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("Error: \(String(describing: viewModel.errorMessage))")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Retry") {
                        Task {
                            
                          await  viewModel.fetchData()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    .foregroundColor(.blue)
                }
            }
        }
        .task {
            await viewModel.fetchData(cityLocation)
        }
    }
}


// MARK: - Preview
//struct WeatherDetailsMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Embed in a NavigationView for previewing the navigation title
//        NavigationView {
//            WeatherDetailsMainView(viewModel: WeatherDetailViewModel())
//        }
//    }
//}
