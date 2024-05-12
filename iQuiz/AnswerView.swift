//
//  AnswerView.swift
//  iQuiz
//
//  Created by Non on 12/5/2567 BE.
//

import SwiftUI

struct AnswerView: View {
    @Environment(\.presentationMode) var presentationMode
    let quiz: Quiz
    let currentQuestionIndex: Int
    let selectedOption: Int
    
    var body: some View {
        VStack {
            Text(quiz.questions[currentQuestionIndex].text)
                .font(.title)
                .padding()
            
            ForEach(0..<quiz.questions[currentQuestionIndex].answers.count, id: \.self) { index in
                HStack {
                    Text(quiz.questions[currentQuestionIndex].answers[index])
                        .padding()
                        .background(index == quiz.questions[currentQuestionIndex].correctAnswer ? Color.green : (index == selectedOption ? Color.red : Color.clear))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            Button(action: {
                if currentQuestionIndex + 1 < quiz.questions.count {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    // Navigate to FinishedView
                }
            }) {
                Text("Next")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
            .gesture(DragGesture(minimumDistance: 50)
                        .onEnded { value in
                            if value.translation.width > 0 {
                                if currentQuestionIndex + 1 < quiz.questions.count {
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    // Navigate to FinishedView
                                }
                            }
                        })
        }
        .navigationBarTitle("Answer", displayMode: .inline)
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(quiz: Quiz.sampleQuiz(), currentQuestionIndex: 0, selectedOption: 0)
    }
}
