//
//  PieChart.swift
//  James
//
//  Created by Ionel Lescai on 14.03.2022.
//

import SwiftUI

struct PieChart: View {
    public let title: String
    public let values: [Double]
    public var valueTitles: [String]
    public var colors: [Color]
    
    public var backgroundColor: Color
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                GeometryReader { geo in
                    ZStack {
                        ForEach(0..<values.count) { i in
                            PieSliceView(pieSliceData: slices[i])
                        }
                    }
                    .background(backgroundColor)
                    .foregroundColor(Color.white)
                }
                .aspectRatio(1, contentMode: .fit)
                .padding(.bottom, 10)
                
                Text(title)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                ForEach(0..<values.count) { index in
                    HStack {
                        Rectangle()
                            .aspectRatio(1.0, contentMode: .fit)
                            .frame(height: 10)
                            .foregroundColor(colors[index])
                        
                        Text(valueTitles[index])
                    }
                }
                
                Spacer()
            }
        } // HStack
    } // body
}

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct PieSliceView: View {
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geo.size.width, geo.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    
                }
                .fill(pieSliceData.color)
                
                Text(pieSliceData.text)
                    .shadow(color: .black, radius: 5)
                    .position(
                        x: geo.size.width * 0.5 * CGFloat(1.0 + 0.5 * cos(midRadians)),
                        y: geo.size.height * 0.5 * CGFloat(1.0 - 0.5 * sin(midRadians))
                    )
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(title: "Pie Chart",
                 values: [1300, 500, 300],
                 valueTitles: ["A", "B", "C"],
                 colors: distinctColors(count: 3),
                 backgroundColor: .clear)
            .previewLayout(.sizeThatFits)
    }
}
