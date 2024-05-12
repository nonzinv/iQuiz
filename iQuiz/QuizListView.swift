//
//  QuizListView.swift
//  iQuiz
//
//  Created by Non on 12/5/2567 BE.
//

import SwiftUI

struct QuizListView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    
    var body: some View {
        List(viewModel.quizzes) { quiz in
            NavigationLink(destination: QuestionView(quiz: quiz, currentQuestionIndex: 0)) {
                HStack {
                    Image(systemName: "book.fill") // Using a placeholder icon
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                    VStack(alignment: .leading) {
                        Text(quiz.title)
                            .font(.headline)
                        Text(quiz.desc)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct QuizListView_Previews: PreviewProvider {
    static var previews: some View {
        QuizListView()
            .environmentObject(QuizViewModel())
    }
}
