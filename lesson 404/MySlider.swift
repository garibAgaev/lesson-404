//
//  MySlider.swift
//  lesson 404
//
//  Created by Garib Agaev on 20.09.2023.
//

import SwiftUI

struct MySlider: UIViewRepresentable {
    
    let range : ClosedRange<Double>
    let targetValue: Double
    @Binding var value: Double
    @Binding var opacity: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.sliderTarget),
            for: .valueChanged
        )
        slider.minimumValue = Float(range.lowerBound)
        slider.maximumValue = Float(range.upperBound)
        slider.thumbTintColor = .red
        slider.thumbTintColor?.withAlphaComponent(opacity)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.thumbTintColor = .red.withAlphaComponent(computeScore())
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(targetValue: targetValue, value: $value, opacity: $opacity)
    }
    
    private func computeScore() -> Double {
        1 - abs(targetValue - value) / getRange(in: range)
    }
    
    private func getRange<T: AdditiveArithmetic>(in range: ClosedRange<T>) -> T {
        range.upperBound - range.lowerBound
    }
}

extension MySlider {
    class Coordinator: NSObject {
        let targetValue: Double
        @Binding var value: Double
        @Binding var opacity: Double
        
        init(targetValue: Double, value: Binding<Double>, opacity: Binding<Double>) {
            self.targetValue = targetValue
            self._value = value
            self._opacity = opacity
        }
        
        @objc func sliderTarget(_ sender: UISlider) {
            value = Double(sender.value)
            opacity = getAlpha(sender)
        }
        
        private func getAlpha(_ sender: UISlider) -> Double {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            sender.thumbTintColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return alpha
        }
    }
}


struct MySlider_Previews: PreviewProvider {
    static var previews: some View {
        MySlider(
            range: 0...100, targetValue:
                Double.random(in: 0...100),
            value: .constant(Double.random(in: 0...100)),
            opacity: .constant(Double.random(in: 0...1))
        )
    }
}
