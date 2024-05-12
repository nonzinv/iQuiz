//
//  QuizViewModel.swift
//  iQuiz
//
//  Created by Non on 12/5/2567 BE.
//

import Combine
import Foundation

class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var error: QuizError? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchQuizzes()
    }
    
    func fetchQuizzes(from url: String = "https://tednewardsandbox.site44.com/questions.json") {
        guard let url = URL(string: url) else {
            self.error = QuizError(message: "Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                print("Fetched Data: \(String(data: result.data, encoding: .utf8) ?? "Invalid Data")")
                return result.data
            }
            .decode(type: [Quiz].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.error = QuizError(message: error.localizedDescription)
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    self.error = nil
                }
            }, receiveValue: { quizzes in
                self.quizzes = quizzes
                print("Quizzes: \(quizzes)")
            })
            .store(in: &self.cancellables)
    }
}

struct QuizError: Identifiable {
    let id = UUID()
    let message: String
}
