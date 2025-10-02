//
//  LoadingIndicatorView.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-23.
//

import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ProgressView("Loading Weather...")
            .accessibilityIdentifier("LoadingView")
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .font(.headline)
            .foregroundColor(.white)
            .padding()
    }
}

#Preview {
    LoadingIndicatorView()
}
