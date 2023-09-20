//
//  ContentView.swift
//  lesson 404
//
//  Created by Garib Agaev on 19.09.2023.
//

import SwiftUI

struct ContentView: View {
    static let intRange = 0...100
    static var doubleRange: ClosedRange<Double> {
        Double(intRange.lowerBound)...Double(intRange.upperBound)
    }
    @State private var targetValue = Int.random(in: ContentView.intRange)
    @State private var currentValue = Double.random(in: ContentView.doubleRange)
    @State private var opacity = 0.0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Подвиньте слайдер, как можно ближе к: \(targetValue)")
            HStack {
                Text(ContentView.intRange.lowerBound.formatted())
                MySlider(
                    range: ContentView.doubleRange,
                    targetValue: Double(targetValue),
                    value: $currentValue,
                    opacity: $opacity
                )
                Text(ContentView.intRange.upperBound.formatted())
            }
            Button("Проверь меня!") {
                showAlert = true
            }
            .frame(height: 40)
            .alert("Your Score", isPresented: $showAlert) {
                Button("OK") {
                    targetValue = Int.random(in: ContentView.intRange)
                }
            } message: {
                Text(computeScore().formatted())
            }
            Button("Начать заново") {
                targetValue = Int.random(in: ContentView.intRange)
            }
            .frame(height: 40)
        }
        .padding()
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return getRange(in: ContentView.intRange) - difference
    }
    
    private func getRange<T: AdditiveArithmetic>(in range: ClosedRange<T>) -> T {
        range.upperBound - range.lowerBound
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
