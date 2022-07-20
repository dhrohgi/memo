//
//  ContentModel.swift
//  memo
//
//  Created by dennis on 7/4/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ContentModel: ObservableObject {
    
    @Published var loggedIn = false
    
    func checkLogin() {
        
        // Check if there is a current user to determine logged in status
        loggedIn = Auth.auth().currentUser != nil ? true : false
        
        // Check if user meta data has been fetched. if the user was already logged in from a previous session, we need to get their data in a separate call
        // 이미 앞전 세션에 로그인이 되어 있는 상태에서 user data 를 불러오지 못하기 때문에, checkLogin() 함수를 call 할 때 만약 name 에 empty 라면(nil 이 아님) getUserData() 함수를 다시 call 해준다.
        if UserService.shared.user.name == "" {
            getUserData()
        }
        
    }
    
    func getUserData() {
        
        // Check that there's a logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // Get the meta data for that user
        let db = Firestore.firestore()
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        ref.getDocument { snapshot, error in
            
            // Check there's no errors
            guard error == nil, snapshot != nil else {
                print(error!.localizedDescription)
                return
            }
            
            // Parse the data out and set the user meta data
            let data = snapshot!.data()
            let user = UserService.shared.user
            user.name = data?["name"] as? String ?? ""
            user.email = data?["email"] as? String ?? ""
            user.clearanceLevel = data?["clearanceLevel"] as? Int ?? 1
            
        }
        
        
    }
    
}
