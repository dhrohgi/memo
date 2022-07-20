//
//  ProfileView.swift
//  memo
//
//  Created by dennis on 7/4/22.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        Button {
            
            try! Auth.auth().signOut()
            
            model.checkLogin()
            
        } label: {
            Text("Sign Out!")
        }

        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
