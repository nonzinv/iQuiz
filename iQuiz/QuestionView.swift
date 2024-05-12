//
//  QuestionView.swift
//  iQuiz
//
//  Created by Non on 12/5/2567 BE.
//

import SwiftUI

struct QuestionView: View {
    @State private var selectedOption: Int? = nil
    @State private var showAnswer: Bool = false
    let quiz: Quiz
    let currentQuestionIndex: Int
    
    var body: some View {
        VStack {
            Text(quiz.questions[currentQuestionIndex].text)
                .font(.title)
                .padding()
            
            ForEach(0..<quiz.questions[currentQuestionIndex].answers.count, id: \.self) { index in
                HStack {
                    Button(action: {
                        self.selectedOption = index
                    }) {
                        Text(quiz.questions[currentQuestionIndex].answers[index])
                            .padding()
                            .background(self.selectedOption == index ? Color.blue : Color.clear)
                            .foregroundColor(self.selectedOption == index ? .white : .black)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            
            Button(action: {
                if let selectedOption = selectedOption {
                    self.showAnswer = true
                }
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
            .disabled(selectedOption == nil)
            .gesture(DragGesture(minimumDistance: 50)
                        .onEnded { value in
                            if value.translation.width > 0 {
                                if let selectedOption = selectedOption {
                                    self.showAnswer = true
                                }
                            }
                        })
            .navigationBarTitle("Question \(currentQuestionIndex + 1)", displayMode: .inline)
            .navigationBarItems(trailing: Button("Next") {
                if let selectedOption = selectedOption {
                    self.showAnswer = true
                }
            })
            .sheet(isPresented: $showAnswer) {
                if currentQuestionIndex + 1 < quiz.questions.count {
                    QuestionView(quiz: quiz, currentQuestionIndex: currentQuestionIndex + 1)
                } else {
                    FinishedView(score: quiz.correctAnswers, total: quiz.questions.count)
                }
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(quiz: Quiz.sampleQuiz(), currentQuestionIndex: 0)
    }
}
