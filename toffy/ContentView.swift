//
//  ContentView.swift
//  toffy
//
//  Created by Rahul K M on 31/12/23.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: QuestionViewModel

    var body: some View {
        NavigationView {
            HomeView(viewModel: viewModel)
                .environmentObject(viewModel) // Pass the viewModel as an environment object
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: QuestionViewModel())
    }
}
