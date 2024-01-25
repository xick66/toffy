//
//sk-eeevtua-ykkuiqi-vh4zdwa-uymnv7i  - helicone api key
//
//  QuestionviewModel.swift
//  toffy
//
//  Created by Rahul K M on 31/12/23.
//

//    private let apiURL = "https://api-inference.huggingface.co/models/MBZUAI/LaMini-Flan-T5-248M"
//    private let apiKey = "Bearer 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"

//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
//https://api.openai.com/v1/chat/completions


import Foundation

class QuestionViewModel: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var userResponses: [String] = []
    @Published var hasCompletedQuestions = false
    @Published var questions: [String] = ["What's the best thing you did today?"]
    @Published var personalizedGuidance: String = ""

    private let apiURL = "https://oai.hconeai.com/v1/chat/completions" // Helicone API URL
    private let apiKey = "Bearer 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" // Replace with your actual OpenAI API key
    private let heliconeAPIKey = "Bearer sk-eeevtua-ykkuiqi-vh4zdwa-uymnv7i" // Replace with your actual Helicone API key
    private let model = "gpt-3.5-turbo-1106" // Replace with the actual GPT model identifier

    func fetchQuestionsFromLLM() {
        if currentQuestionIndex >= 5 {
            hasCompletedQuestions = true
            generatePersonalizedGuidance()
            return
        }

        var messages: [[String: String]] = []
        for (index, response) in userResponses.enumerated() {
            messages.append(["role": "user", "content": response])
            if index < questions.count {
                messages.append(["role": "assistant", "content": questions[index]])
            }
        }

        let prompt = currentQuestionIndex == 0 ? "Ask a question to start a conversation based on the user's day." :
            "Be my gen-Z best friend, we're both 20 and love gossip. Ask a specific follow-up about our day's chat, keep it casual and brief, without sounding too probing."
        messages.append(["role": "system", "content": prompt])

        let payload: [String: Any] = [
            "model": model,
            "messages": messages
        ]
        
//        Based on the conversation so far, act like my best friend and ask a relevant follow-up question and after one follow-up question ask about something else if needed, otherwise continue with the same context, keep the question length short
        
        
//        act like my best friend, we both are two 20yo gossip girls, based on the conversation so far, ask a follow up question, seem interested, keep the questions short
        
        
        makeAPIRequest(with: payload) { [weak self] response in
            guard let self = self else { return }
            if let newQuestion = response.first {
                self.questions.append(newQuestion)
                self.currentQuestionIndex += 1
            }
        }
    }
    
    private func makeAPIRequest(with payload: [String: Any], completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: apiURL) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(heliconeAPIKey, forHTTPHeaderField: "Helicone-Auth")
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload)
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   !choices.isEmpty,
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    DispatchQueue.main.async {
                        completion([content])
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
    
    private func generatePersonalizedGuidance() {
        var messages: [[String: String]] = []
        for (index, response) in userResponses.enumerated() {
            messages.append(["role": "user", "content": response])
            if index < questions.count {
                messages.append(["role": "assistant", "content": questions[index]])
            }
        }

        let inputPrompt = "Considering the user's previous responses and our conversation so far, provide supportive and personalized guidance."

        messages.append(["role": "system", "content": inputPrompt])

        let payload: [String: Any] = [
            "model": model,
            "messages": messages
        ]

        makeAPIRequest(with: payload) { [weak self] guidanceResponse in
            guard let self = self else { return }
            if let guidance = guidanceResponse.first {
                DispatchQueue.main.async {
                    self.personalizedGuidance = guidance
                }
            }
        }
    }

    func submitResponse(_ response: String) {
        userResponses.append(response)
        fetchQuestionsFromLLM()
    }

    func startNewSession() {
        userResponses = []
        currentQuestionIndex = 0
        hasCompletedQuestions = false
        questions = ["What's the best thing you did today?"]
    }
}

