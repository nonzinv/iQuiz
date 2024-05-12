import Foundation

struct Quiz: Identifiable, Decodable {
    var id = UUID()
    var title: String
    var desc: String
    var questions: [Question]
    
    var correctAnswers: Int {
        return questions.filter { $0.isCorrect }.count
    }
    
    enum CodingKeys: String, CodingKey {
        case title, desc, questions
    }
}

struct Question: Identifiable, Decodable {
    var id = UUID()
    var text: String
    var answer: String
    var answers: [String]
    var selectedAnswer: Int?
    
    var correctAnswer: Int? {
        return Int(answer)
    }
    
    var isCorrect: Bool {
        guard let selectedAnswer = selectedAnswer, let correctAnswer = correctAnswer else {
            return false
        }
        return selectedAnswer == correctAnswer
    }
    
    enum CodingKeys: String, CodingKey {
        case text, answer, answers
    }
}

extension Quiz {
    static func sampleQuiz() -> Quiz {
        return Quiz(
            title: "Sample Quiz",
            desc: "This is a sample quiz.",
            questions: [
                Question(text: "Sample Question 1", answer: "0", answers: ["Option 1", "Option 2", "Option 3"]),
                Question(text: "Sample Question 2", answer: "1", answers: ["Option 1", "Option 2", "Option 3"])
            ]
        )
    }
}
