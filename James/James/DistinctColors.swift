//
//  DistinctColors.swift
//  James
//
//  Created by Ionel Lescai on 14.03.2022.
//

import SwiftUI

struct DistinctColors: View {
    let colors: [Color] = distinctColors(count: 30,
                                         saturationRange: 0.3...0.7,
                                         brightnessRange: 0.5...1)
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<colors.count) { index in
                Rectangle()
                    .foregroundColor(colors[index])
                    .frame(width: 30, height: 30)
            }
        }
    }
}

func distinctColors(count: Int,
                    saturationRange: ClosedRange<Double> = 1...1,
                    brightnessRange: ClosedRange<Double> = 1...1) -> [Color] {
    stride(from: 0, through: 1, by: 1/(Double(count)))
        .map {
            Color(hue: $0,
                  saturation: Double.random(in: saturationRange),
                  brightness: Double.random(in: brightnessRange))
        }
        .dropLast()
}

struct DistinctColors_Previews: PreviewProvider {
    static var previews: some View {
        DistinctColors()
    }
}
