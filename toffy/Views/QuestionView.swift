//
//  QuestionView.swift
//  toffy
//
//  Created by Rahul K M on 01/01/24.
//
import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var viewModel: QuestionViewModel
    @State private var userResponse: String = ""

    var body: some View {
        VStack {
            // Display questions if they are not completed
            if !viewModel.hasCompletedQuestions && viewModel.currentQuestionIndex < viewModel.questions.count {
                let question = viewModel.questions[viewModel.currentQuestionIndex]

                Text(question)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                TextEditor(text: $userResponse)
                    .frame(height: 200)
                    .border(Color.gray, width: 1)
                    .padding()

                Button("Submit") {
                    viewModel.submitResponse(userResponse)
                    userResponse = ""
                    // Check if all questions are answered to generate guidance
                    if viewModel.currentQuestionIndex == viewModel.questions.count {
                        viewModel.generatePersonalizedGuidance()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            // Display the personalized guidance if questions are completed
            else if viewModel.hasCompletedQuestions {
                Text(viewModel.personalizedGuidance)
                    .padding()
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = QuestionViewModel()
        return QuestionView().environmentObject(viewModel)
    }
}
