//
//  VisibleModifier.swift
//  WeatherForecastApp
//
//  Created by Samuel Pinheiro Junior on 2025-07-24.
//


import SwiftUI

public struct VisibleModifier: ViewModifier {
    
    private let visible: Bool
    
    public init(visible: Bool) {
        self.visible = visible
    }
    
    public func body(content: Content) -> some View {
        if visible {
            content
        }
    }
}

extension View {
    public func visible(_ visible: Bool) -> some View {
        modifier(VisibleModifier(visible: visible))
    }
}