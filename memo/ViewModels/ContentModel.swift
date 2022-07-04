//
//  ContentModel.swift
//  memo
//
//  Created by dennis on 7/4/22.
//

import Foundation
import FirebaseAuth

class ContentModel: ObservableObject {
    
    @Published var loggedIn = false
    
    func checkLogin() {
        
        loggedIn = Auth.auth().currentUser != nil ? true : false
        
    }
    
}
