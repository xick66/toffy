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
    
    private let apiURL = "https://api-inference.huggingface.co/models/MBZUAI/LaMini-Flan-T5-248M"
    private let apiKey = "Bearer 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"
    
    func fetchQuestionsFromLLM() {
        let responsesString = userResponses.joined(separator: " ")
        let inputPrompt: String
        if currentQuestionIndex == 0 {
            inputPrompt = "Ask me about my day as if I am your best friend and we are two gossip girls talking to each other at the end of the day"
        } else {
            inputPrompt = "Act like you are my best friend, ask a follow up question as if you are interested to know more considering: \(responsesString)"
        }
        
        let payload: [String: Any] = [
            "inputs": inputPrompt
        ]
        
        makeAPIRequest(with: payload) { [weak self] response in
            guard let self = self else { return }
            if let newQuestion = response.first as? String {
                if self.currentQuestionIndex < self.questions.count {
                    self.questions[self.currentQuestionIndex] = newQuestion
                } else {
                    self.questions.append(newQuestion)
                }
            }
        }
    }
    
    func generatePersonalizedGuidance() {
        let responsesString = userResponses.joined(separator: " ")
        let payload: [String: Any] = [
            "inputs": "Act like a supportive friend of mine, ask a follow up question considering: \(responsesString)"
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
    
    func submitResponse(_ response: String) {
        userResponses.append(response)
        if currentQuestionIndex < 4 {
            currentQuestionIndex += 1
            fetchQuestionsFromLLM()
        } else {
            hasCompletedQuestions = true
            generatePersonalizedGuidance()
        }
    }
    
    func startNewSession() {
        userResponses = []
        currentQuestionIndex = 0
        hasCompletedQuestions = false
        personalizedGuidance = ""
        fetchQuestionsFromLLM()
    }
}
