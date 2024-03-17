//
//  Homeview.swift
//  toffy
//
//  Created by Rahul K M on 01/01/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: QuestionViewModel

    var body: some View {
        ZStack {
            if viewModel.hasCompletedQuestions {
                
                Text(viewModel.personalizedGuidance)
            } else {
                QuestionView().environmentObject(viewModel)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = QuestionViewModel()
        viewModel.questions = ["Sample question 1", "Sample question 2"]
        return HomeView(viewModel: viewModel).environmentObject(viewModel)
    }
}
