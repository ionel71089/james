//
//  Charts.swift
//  James
//
//  Created by Ionel Lescai on 14.03.2022.
//

import SwiftUI

struct Charts: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            HStack {
                BarChart(title: "Job tracking count", data: $model.jobTrackingData)
                PieChart(title: "Job Status",
                         values: model.jobStatus.map { Double($0.1) },
                         valueTitles: model.jobStatus.map { "\($0.0) (\($0.1))" },
                         colors: [Color(hex: 0xa084ff), Color(hex: 0xff85a0), Color(hex: 0x84ffa0)],
                         backgroundColor: .clear)
                    .frame(height: 300)
                Spacer()
            }
        }
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        Charts()
            .environmentObject(Model())
    }
}

public extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
