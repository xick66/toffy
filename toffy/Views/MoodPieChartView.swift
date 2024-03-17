//
//  MoodPieChartView.swift
//  toffy
//
//  Created by Rahul K M on 02/01/24.
//

import SwiftUI

struct MoodPieChartView: View {
    var sentiments: [Int]
    @State private var selectedSlice: Int? = nil

    var body: some View {
        VStack {
            Text("Weekly Mood Distribution")
                .font(.headline)
                .padding()

            PieChartView(slices: createPieSlices(), selectedSlice: $selectedSlice)
                .frame(height: 300)

            if let selectedSlice = selectedSlice {
                Text("Sentiment \(selectedSlice) is \(percentage(for: selectedSlice))% of your week")
                    .padding()
            }
        }
    }

    private func createPieSlices() -> [PieSliceData] {
       //Complete this soon
    }

    private func colorForSentiment(_ sentiment: Int) -> Color {
        // Complete this soon
    }

    private func percentage(for sentiment: Int) -> Double {
        let count = Double(sentiments.filter { $0 == sentiment }.count)
        return (count / Double(sentiments.count)) * 100
    }
}

struct PieChartView: View {
    var slices: [PieSliceData]
    @Binding var selectedSlice: Int?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(slices.indices, id: \.self) { index in
                    PieSliceView(pieSliceData: self.slices[index])
                        .onTapGesture {
                            self.selectedSlice = index + 1
                        }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct MoodPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        MoodPieChartView(sentiments: [1, 2, 3, 4, 5, 1, 3])
    }
}
