//
//  LoginView.swift
//  memo
//
//  Created by dennis on 7/4/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var loginMode = Constants.LoginMode.login
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State var errorMessage: String?
    
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
            
            // Logo
            Image(systemName: "text.book.closed")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150)
            
            // Title
            Text("Personal Memo")
            
            Spacer()
            
            // Picker
            Picker(selection: $loginMode) {
                Text("Login")
                    .tag(Constants.LoginMode.login)
                
                Text("Sign Up")
                    .tag(Constants.LoginMode.createAccount)
            } label: {
                
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // Textfield
            Group {
             
                TextField("Email", text: $email)
                
                if loginMode == Constants.LoginMode.createAccount {
                    TextField("Name", text: $name)
                }
                
                SecureField("Password", text: $password)
                
                if errorMessage != nil {
                    Text(errorMessage!)
                }
                    
            }
            
            // Button
            Button {

                // Log the user in
                if loginMode == Constants.LoginMode.login {
                    
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        
                        guard error == nil else {
                            self.errorMessage = error!.localizedDescription
                            return
                        }
                        
                        // Clear error message
                        self.errorMessage = nil
                        
                        // TODO: Fetch the user meta data
                        self.model.getUserData()
                        
                        // Change the view to logged in view
                        self.model.checkLogin()
                    }
                    
                }
                else {
                    // Create new user
                    
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        
                        guard error == nil else {
                            
                            self.errorMessage = error!.localizedDescription
                            return
                            
                        }
                        
                        // Clear error message
                        self.errorMessage = nil
                        
                        // Save the first name
                        let firebaseUser = Auth.auth().currentUser
                        let db = Firestore.firestore()
                        let ref = db.collection("users").document(firebaseUser!.uid)
                        ref.setData(["name" : name], merge: true)
                        ref.setData(["email" : email], merge: true)
                        
                        // Update the user meta data
                        let user = UserService.shared.user
                        user.name = name
                        
                        self.model.checkLogin()
                        
                    }
                    
                    
                }
                
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
