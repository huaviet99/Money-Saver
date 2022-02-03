//
//  DemoViewModel.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import Foundation
import RxSwift

class DemoViewModel {
    private let userPublishSubject: PublishSubject<(email: String, password: String)> = PublishSubject()
    private (set) var loggedUser: Observable<(email: String, password: String)>
    
    init(){
        self.loggedUser = userPublishSubject.asObservable()
    }
    
    func validateAndLogin(email: String?, password: String?) {
        guard let email = email, let password = password else {
            print("validate failed")
            return
        }
        userPublishSubject.onNext((email: email, password: password))
    }
}
