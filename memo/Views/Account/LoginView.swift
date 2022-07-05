//
//  LoginView.swift
//  memo
//
//  Created by dennis on 7/4/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var loginMode = Constants.LoginMode.login
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    
    var buttonText: String {
        
        if loginMode == Constants.LoginMode.login {
            return "Login"
        }
        else {
            return "Sign Up"
        }
        
    }
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            Spacer()
            
            Image(systemName: "text.book.closed")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150)
            
            Text("Personal Memo")
            
            Spacer()
            
            Picker(selection: $loginMode) {
                Text("Login")
                    .tag(Constants.LoginMode.login)
                
                Text("Sign Up")
                    .tag(Constants.LoginMode.createAccount)
            } label: {
                
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TextField("Email", text: $email)
            
            if loginMode == Constants.LoginMode.login {
                TextField("Name", text: $name)
            }
            
            SecureField("Password", text: $password)
            
            Button {
                
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.brown)
                        .frame(height: 40)
                        .cornerRadius(10)
                    Text(buttonText)
                        .foregroundColor(.white)
                }
                
            }

            Spacer()
            
        }
        .padding(.horizontal, 40)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
