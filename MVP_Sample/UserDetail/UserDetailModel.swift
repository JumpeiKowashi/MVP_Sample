//
//  UserDetailModel.swift
//  MVP_Sample
//
//  Created by Jumpei Kowashi on 2022/09/19.
//

import Foundation

protocol UserDetailModelInput {
    func fetchUser(completion: @escaping(String) -> ())
}

class UserDetailModel: UserDetailModelInput {
 
    private let username: String!
    
    init(username: String) {
        self.username = username
    }
    
    func fetchUser(completion: @escaping (String) -> ()) {
        // 本来であればここでAPIコールなどをやる
        // ここでAPIぽいことをやっていることにする
        completion(username)
    }
}
