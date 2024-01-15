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
            // Check if there are still questions to be answered
            if !viewModel.hasCompletedQuestions {
                // Display the current question if available
                if viewModel.currentQuestionIndex < viewModel.questions.count {
                    let question = viewModel.questions[viewModel.currentQuestionIndex]

                    Text(question)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                // Text editor for user response
                TextEditor(text: $userResponse)
                    .frame(height: 200)
                    .border(Color.gray, width: 1)
                    .padding()

                // Submit button
                Button("Submit") {
                    viewModel.submitResponse(userResponse)
                    userResponse = ""
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                // Display personalized guidance after all questions are answered
                Text(viewModel.personalizedGuidance)
                    .padding()
            }
        }
        .onAppear {
            // Fetch the first set of questions when the view appears
            viewModel.fetchQuestionsFromLLM()
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = QuestionViewModel()
        return QuestionView().environmentObject(viewModel)
    }
}

//import SwiftUI
//
//struct QuestionView: View {
//    @EnvironmentObject var viewModel: QuestionViewModel
//    @State private var userResponse: String = ""
//
//    var body: some View {
//        VStack {
//            // Check if there are more questions to ask
//            if !viewModel.hasCompletedQuestions && viewModel.currentQuestionIndex < viewModel.questions.count {
//                let question = viewModel.questions[viewModel.currentQuestionIndex]
//
//                Text(question)
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
//                    .padding()
//
//                TextEditor(text: $userResponse)
//                    .frame(height: 200)
//                    .border(Color.gray, width: 1)
//                    .padding()
//
//                Button("Submit") {
//                    viewModel.submitResponse(userResponse)
//                    userResponse = ""
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            // If all questions have been answered, display the guidance
//            else if viewModel.hasCompletedQuestions {
//                Text(viewModel.personalizedGuidance)
//                    .padding()
//            }
//        }
//    }
//}
//
//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView().environmentObject(QuestionViewModel())
//    }
//}


