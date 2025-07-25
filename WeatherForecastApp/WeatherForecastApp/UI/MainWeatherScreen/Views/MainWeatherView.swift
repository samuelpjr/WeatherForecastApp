//
//  MainView.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-22.
//

import SwiftUI

struct MainWeatherView: View {
    
    @State var viewModel: MainWeatherViewModel
    @State private var searchText = ""
    @State private var isSearchBarVisible = true
    @State private var show = false
    @State private var text: String = ""
    @State var locale: (lat: Double, lon: Double)?
    @FocusState private var isTyping: Bool
    
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                switch viewModel.viewState {
                case .loading:
                    LoadingIndicatorView()
                case .loaded:
                    ScrollView {
                        searchBarView
                        CurrentWeatherCard(viewModel: viewModel)
                        UpcomingWeekView(
                            dailyForecasts: viewModel.dailyForecasts,
                            useCase: viewModel.getCurrentWeatherUseCase as! GetWeatherUseCase,
                            locale: self.$locale
                        )
                    }
                case .error(_):
                    ErrorState(viewModel: viewModel)
                }
            }
            .task {
                await viewModel.fetchWeatherData()
                locale = viewModel.locale
            }
        }
    }
    
    var searchBarView: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: show ? 15 : 30)
                    .foregroundStyle(.thinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 5)
                    .padding(.leading, 5)
                
                HStack {
                    Image(systemName: show ? "xmark" : "magnifyingglass")
                        .accessibilityIdentifier("SearchIcon")
                        .font(.title2).bold()
                        .foregroundStyle(Color.white)
                        .contentTransition(.symbolEffect)
                        .onTapGesture {
                            withAnimation {
                                text = ""
                                show.toggle()
                                isTyping.toggle()
                            }
                        }
                    TextField("Type city name...", text: $text)
                        .accessibilityIdentifier("SearchTextField")
                        .focused ($isTyping)
                        .opacity(show ? 1 : 0)
                        .foregroundStyle(.primary)
                        .bold()
                    
                    Button("Search") {
                        Task {
                            await viewModel.fetchLocationBy(cityName: text)
                        }
                    }
                    .accessibilityIdentifier("SearchButton")
                    .padding(.trailing, show ? 15 : 0)
                }
                .padding(.leading, 17)
            }
            .frame(width: show ? nil : 50 , height: 50)
            .frame (maxWidth: .infinity, alignment: .leading)
            .frame (height: 70).clipped()
            .padding(.horizontal, 15)
            
            List(viewModel.locationsList) { locale in
                Text("\(locale.name), \(locale.state) \(locale.country)")
                    .accessibilityIdentifier("LocationRow_\(locale.name)")
                    .onTapGesture {
                        withAnimation {
                            show.toggle()
                            isTyping.toggle()
                        }
                        self.locale = (lat: locale.lat, lon: locale.lon)
                        Task {
                           await viewModel.fetchWeatherData((lat: locale.lat, lon: locale.lon))
                        }
                        viewModel.locationsList.removeAll()
                    }
            }
            .listStyle(.inset)
            .frame (maxWidth: .infinity, alignment: .leading)
            .frame (height: 220).clipped()
            .visible(!viewModel.locationsList.isEmpty && show)
        }
        .onChange(of: show, initial: false) {
            viewModel.locationsList.removeAll()
        }
    }
}

// MARK: - Preview Provider
struct MainWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        
        let apiService = APIService()
        let productRepository = APIWeatherRepository(apiService: apiService)
        let getCurrentWeather = GetWeatherUseCase(weatherRepository: productRepository)
        let viewModel = MainWeatherViewModel(getCurrentWeatherUseCase: getCurrentWeather)
        let view = MainWeatherView(viewModel: viewModel)
        return view
        
    }
}
