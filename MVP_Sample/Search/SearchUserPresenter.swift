//
//  Presenter.swift
//  MVP_Sample
//
//  Created by Jumpei Kowashi on 2022/09/18.
//

import UIKit

protocol SearchUserPresenterInput {
    var numberOfUsers: Int { get }
    func user(forRow row: Int) -> String?
    func didSelectRow(at indexPath: IndexPath)
    func didTapSearchButton(text: String?)
}


protocol SearchUserPresenterOutput: AnyObject {
    func updateUsers(_ users: [String])
    func transitionToUserDetail(userName: String)
}


final class SearchUserPresenter {
    
    private(set) var users: [String] = []
    private weak var view: SearchUserPresenterOutput!
    private var model: SearchUserModelInput
    
    
    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
    }
}

extension SearchUserPresenter: SearchUserPresenterInput {
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forRow row: Int) -> String? {
        guard row < users.count else{return nil}
        return users[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let user = users[indexPath.row]
        view.transitionToUserDetail(userName: user)
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else{return}
        model.fetchUser(query: query) { [weak self] users in
            self?.users = users
            
            DispatchQueue.main.async {
                self?.view.updateUsers(users)
            }
        }
        
    }
}
