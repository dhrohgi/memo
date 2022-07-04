//
//  LaunchView.swift
//  memo
//
//  Created by dennis on 7/4/22.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.loggedIn == false {
            
            LoginView()
                .onAppear {
                    model.checkLogin()
                }
            
        }
        else {
            
            TabView {
                
                HomeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                
                ProfileView()
                    .tabItem {
                        VStack {
                            Image(systemName: "face.smiling")
                            Text("Profile")
                        }
                    }
                
            }
            
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
