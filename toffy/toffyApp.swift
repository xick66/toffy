//
//  toffyApp.swift
//  toffy
//
//  Created by Rahul K M on 31/12/23.
//

import SwiftUI

@main
struct toffyApp: App {
    @StateObject private var viewModel = QuestionViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

