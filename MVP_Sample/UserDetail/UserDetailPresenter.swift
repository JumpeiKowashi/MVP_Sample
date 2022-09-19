//
//  UserDetailPresenter.swift
//  MVP_Sample
//
//  Created by Jumpei Kowashi on 2022/09/19.
//

import UIKit


protocol UserDetailPresenterInput {
    func viewDidLoad()
}

protocol UserDetailPresenterOutput: AnyObject {
    func updateUsername(_ username: String)
}

class UserDetailPresenter {
    private var usernamme: String
    
    private weak var view: UserDetailPresenterOutput!
    private var model: UserDetailModelInput
    
    init(usernamme: String, view: UserDetailPresenterOutput!, model: UserDetailModelInput) {
        self.usernamme = usernamme
        self.view = view
        self.model = model
    }
}

// Input内に関数を定義して、切り離しているように見えなくもない
extension UserDetailPresenter: UserDetailPresenterInput {
    func viewDidLoad() {
        self.model.fetchUser { [weak self] resultUsername in
            DispatchQueue.main.async {
                self?.view.updateUsername(resultUsername)
            }
        }
    }
}
