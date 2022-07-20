//
//  UserService.swift
//  memo
//
//  Created by dennis on 7/19/22.
//

import Foundation

class UserService {
    
    var user = User()
    
    static var shared = UserService()
    
    private init() {
        
    }
    
}
