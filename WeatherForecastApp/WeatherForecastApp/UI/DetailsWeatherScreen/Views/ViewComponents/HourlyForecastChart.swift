//
//  HourlyForecastChart.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI
import Charts

struct HourlyForecastChart: View {
    
    @State var viewModel: DetailsWeatherViewModel
    
    init (viewModel: DetailsWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hourly Forecast")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
                .foregroundColor(.white)
            
            Chart(viewModel.hourlyChartData) { dataPoint in
                LineMark(
                    x: .value("Hour", dataPoint.hour),
                    y: .value("Temperature", dataPoint.temperature)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.blue)
                
                PointMark(
                    x: .value("Hour", dataPoint.hour),
                    y: .value("Temperature", dataPoint.temperature)
                )
                .foregroundStyle(.blue)
                .annotation(position: .top) {
                    Text("\(Int(dataPoint.temperature))°")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel {
                        if let temp = value.as(Double.self) {
                            Text("\(Int(temp))°")
                        }
                    }
                }
            }
            .frame(height: 180)
            .padding()
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
            
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    HourlyForecastChart()
//}
