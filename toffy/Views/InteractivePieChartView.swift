//
//  InteractivePieChartView.swift
//  toffy
//
//  Created by Rahul K M on 05/01/24.
//

import SwiftUI

struct InteractivePieChartView: View {
    var slices: [PieSliceData]
    @State private var selectedSliceIndex: Int?

    var body: some View {
        ZStack {
            ForEach(slices.indices, id: \.self) { index in
                PieSliceView(slice: self.slices[index])
                    .onTapGesture {
                        self.selectedSliceIndex = index
                    }
            }

            if let index = selectedSliceIndex, slices.indices.contains(index) {
               
                VStack {
                    Text("Mood: \(sentimentDescription(index))")
                    Text("Percentage: \(formattedPercentage(slices[index].value))%")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }

    private func sentimentDescription(_ index: Int) -> String {
        
        ["Very Happy", "Happy", "Neutral", "Unhappy", "Very Unhappy"][index]
    }

    private func formattedPercentage(_ value: Double) -> String {
        String(format: "%.2f", value * 100)
    }
}

struct PieSliceView: View {
    let slice: PieSliceData

    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let startAngle = CGFloat(slice.startAngle.radians)
            let endAngle = CGFloat(slice.endAngle.radians)

            Path { path in
                path.move(to: center)
                path.addArc(center: center, radius: radius, startAngle: Angle(radians: Double(startAngle)), endAngle: Angle(radians: Double(endAngle)), clockwise: false)
                path.closeSubpath()
            }
            .fill(slice.color)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}




struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    var value: Double 
}


// Preview
struct InteractivePieChartView_Previews: PreviewProvider {
    static var previews: some View {
        InteractivePieChartView(slices: [
            PieSliceData(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 72), color: .green, value: 0.2),
            PieSliceData(startAngle: Angle(degrees: 72), endAngle: Angle(degrees: 144), color: .blue, value: 0.2),
            PieSliceData(startAngle: Angle(degrees: 144), endAngle: Angle(degrees: 216), color: .yellow, value: 0.2),
            PieSliceData(startAngle: Angle(degrees: 216), endAngle: Angle(degrees: 288), color: .orange, value: 0.2),
            PieSliceData(startAngle: Angle(degrees: 288), endAngle: Angle(degrees: 360), color: .red, value: 0.2)
        ])
    }
}
