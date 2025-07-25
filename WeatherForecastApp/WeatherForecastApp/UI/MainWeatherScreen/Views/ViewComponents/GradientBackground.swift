//
//  GradientBackground.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color("TopGradientColor"),
                    Color("BottomGradientColor")
                ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    GradientBackground()
}
