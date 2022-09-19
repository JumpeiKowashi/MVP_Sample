//
//  UserModelInput.swift
//  MVP_Sample
//
//  Created by Jumpei Kowashi on 2022/09/18.
//

import Foundation

protocol SearchUserModelInput {
    func fetchUser(
        query: String,
        completion: @escaping ([String]) -> ())
}


final class SearchUserModel: SearchUserModelInput {
    func fetchUser(query: String, completion: @escaping ([String]) -> ()) {
        
        // ここは擬似的なAPIぽくする
        let users = [
            "キリト",
            "アスナ",
            "リーファ",
            "シノン",
            "ユウキ",
            "ユージオ",
            "アリス",
            "シリカ",
            "リズベット"
        ]
        let results = users.filter({$0.contains(query)})
        
        completion(results)
        
    }
}



