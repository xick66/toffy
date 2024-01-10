//
//  MoodGraphView.swift
//  toffy
//
//  Created by Rahul K M on 02/01/24.
//

import SwiftUI

struct MoodGraphView: View {
    var sentiments: [Int]

    var body: some View {
        VStack {
            Text("Mood Graph")
                .font(.headline)

            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let sentimentHeight = height / 5  // Assuming 5 sentiment levels

                    for (index, sentiment) in sentiments.enumerated() {
                        let xPosition = width * CGFloat(index) / CGFloat(sentiments.count)
                        let yPosition = sentimentHeight * CGFloat(5 - sentiment)

                        if index == 0 {
                            path.move(to: CGPoint(x: xPosition, y: height - yPosition))
                        } else {
                            path.addLine(to: CGPoint(x: xPosition, y: height - yPosition))
                        }
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
            }
        }
    }
}

// Preview Provider
struct MoodGraphView_Previews: PreviewProvider {
    static var previews: some View {
        MoodGraphView(sentiments: [1, 3, 5, 2, 4])
            .frame(height: 200)
    }
}
