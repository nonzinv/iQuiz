//
//  ContentView.swift
//  iQuiz
//
//  Created by Non on 10/5/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = QuizViewModel()
    
    var body: some View {
        NavigationView {
            QuizListView()
                .navigationTitle("iQuiz")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAlert()
                        }) {
                            Image(systemName: "gear")
                        }
                    }
                }
        }
        .environmentObject(viewModel)
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
