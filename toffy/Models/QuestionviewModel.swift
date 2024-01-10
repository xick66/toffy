//
//  QuestionviewModel.swift
//  toffy
//
//  Created by Rahul K M on 31/12/23.
//
import Foundation

class QuestionViewModel: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var userResponses: [String] = []
    @Published var hasCompletedQuestions = false
    @Published var questions: [String] = []
    @Published var personalizedGuidance: String = ""

    private let apiURL = "https://api-inference.huggingface.co/models/google/flan-t5-base"
    private let apiKey = "Bearer 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"
    init() {
        fetchQuestionsFromLLM()
    }

    func fetchQuestionsFromLLM() {
        let payload: [String: Any] = [
            "inputs": "Ask me about today's weather"
        ]
        makeAPIRequest(with: payload) { [weak self] response in
            self?.questions = response.compactMap { $0 as? String }
            self?.currentQuestionIndex = 0
            self?.hasCompletedQuestions = self?.questions.isEmpty ?? true
        }
    }

    func generatePersonalizedGuidance() {
        let responsesString = userResponses.joined(separator: " ")
        let payload: [String: Any] = [
            "inputs": "Look at the below line and give me some insights considering it was my entry in a personal diary, mental health : \(responsesString)"
        ]
        makeAPIRequest(with: payload) { [weak self] response in
            self?.personalizedGuidance = response.first as? String ?? ""
        }
    }

    private func makeAPIRequest(with payload: [String: Any], completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: apiURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload)
            request.httpBody = jsonData
        } catch {
            print("Error: \(error.localizedDescription)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    let texts = jsonArray.compactMap { $0["generated_text"] as? String }
                    DispatchQueue.main.async {
                        completion(texts)
                    }
                } else {
                    let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify data"
                    print("Invalid response format: \(responseString)")
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
            }
        }.resume()
    }

    
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                   let answers = json["answers"] as? [Any] {
//                    DispatchQueue.main.async {
//                        completion(answers)
//                    }
//                } else {
//                    print("Invalid response format")
//                }
//            } catch {
//                print("JSON parsing error: \(error.localizedDescription)")
//            }
//        }.resume()
//    }

    func submitResponse(_ response: String) {
        userResponses.append(response)
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            hasCompletedQuestions = true
            generatePersonalizedGuidance()
        }
    }

    func startNewSession() {
        userResponses = []
        hasCompletedQuestions = false
        personalizedGuidance = ""
        fetchQuestionsFromLLM()
    }
}
