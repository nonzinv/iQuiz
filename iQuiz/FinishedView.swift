//
//  FinishedView.swift
//  iQuiz
//
//  Created by Non on 12/5/2567 BE.
//

import SwiftUI

struct FinishedView: View {
    let score: Int
    let total: Int
    
    var body: some View {
        VStack {
            Text("Quiz Completed")
                .font(.largeTitle)
                .padding()
            
            Text("You scored \(score) out of \(total)")
                .font(.title)
                .padding()
            
            if score == total {
                Text("Perfect!")
                    .font(.title)
                    .padding()
            } else if score > total / 2 {
                Text("Almost!")
                    .font(.title)
                    .padding()
            } else {
                Text("Better luck next time!")
                    .font(.title)
                    .padding()
            }
            
            Button(action: {
                // Navigate back to the quiz list
            }) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
    }
}

struct FinishedView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedView(score: 3, total: 5)
    }
}
