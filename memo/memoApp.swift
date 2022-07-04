//
//  memoApp.swift
//  memo
//
//  Created by dennis on 7/4/22.
//

import SwiftUI
import FirebaseCore

@main
struct memoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
    }
}
