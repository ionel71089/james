//
//  BarChart.swift
//  James
//
//  Created by Ionel Lescai on 14.03.2022.
//

import SwiftUI

struct BarChart: View {
    @State var title: String
    @Binding var data: [(String, Int)]
    
    var maxValue: Int {
        data.map { $0.1 }.max() ?? 0
    }
    
    var linesToShow: [Int] {
        let step = maxValue <= 20 ? 1 : Int(sqrt(Double(maxValue)))
        
        return Array(stride(from: 0, through: maxValue, by: step))
    }
    
    var legend: some View {
        GeometryReader { geo in
            ForEach(linesToShow, id: \.self) { index in
                Text("\(maxValue - index)")
                    .foregroundColor(.white)
                    .offset(y: CGFloat(index)
                                .ilerp(min: 0, max: CGFloat(maxValue))
                                .lerp(min: 0, max: geo.size.height) - 8)
            }
        }
        .frame(width: 20)
    }
    
    var linesAndBars: some View {
        GeometryReader { geo in
            ForEach(linesToShow, id: \.self) { index in
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .offset(y: CGFloat(index)
                                .ilerp(min: 0, max: CGFloat(maxValue))
                                .lerp(min: 0, max: geo.size.height))
                    .opacity(0.5)
            }
            
            HStack(alignment: .bottom) {
                ForEach(0..<data.count) { index in
                    BarChartCell(value: geo.size.height * CGFloat(data[index].1) / CGFloat(maxValue))
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                legend
                linesAndBars
            }
            
            HStack {
                ForEach(0..<data.count) { index in
                    Text(data[index].0)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
            }
            .padding(.leading, 20)
            .padding(.bottom, 10)
            
            Text(title)
                .foregroundColor(.white)
        }
        .padding()
        .foregroundColor(.blue)
        .frame(width: 30 * CGFloat(data.count), height: 30 * CGFloat(data.count))
    }
}

struct BarChartCell: View {
    var value: Double
    
    @State private var isHovered: Bool = false
    
    var body: some View {
        Rectangle()
            .onHover { value in
                isHovered = value
            }
            .opacity(isHovered ? 0.5 : 1.0)
            .frame(height: max(2, value), alignment: .bottom)
            .contextMenu {
                Button {
                    print("Select files")
                } label: {
                    Label("Select files", systemImage: "location.circle")
                }
                
                Button {
                    print("Highlight files")
                } label: {
                    Label("Highlight files", systemImage: "globe")
                }
            }
    }
}

struct BarChart_Previews: PreviewProvider {
    static let sampleData = [
        ("1", 14),
        ("2", 17),
        ("3", 12),
        ("4", 13),
        ("5", 10),
        ("6", 8),
        ("7", 5),
        ("8", 4),
        ("9", 8),
        ("10", 4),
        ("11", 3),
        ("12", 2)
    ]
    
    static var previews: some View {
        BarChart(title: "Sample", data: .constant(sampleData))
    }
}
