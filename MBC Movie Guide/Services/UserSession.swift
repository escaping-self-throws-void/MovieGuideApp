//
//  UserSession.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 12/07/2022.
//

import Foundation
import RxSwift

final class UserSession {
    static let shared = UserSession()
    
    var currentUser: Observable<User>? {
        didSet {
            getUser()
        }
    }
    
    var user: User?
    var isGuest: Bool = false
    
    private init() {}
    
    private func getUser() {
        currentUser?.map { $0 }.subscribe(onNext: { currUser in
            self.user = currUser
        }).dispose()
    }
    
}

