//
//  UserDetailViewController.swift
//  MVP_Sample
//
//  Created by Jumpei Kowashi on 2022/09/19.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    // UserDetailPresenterの中身は見えなくして、関数だけ呼べるようにしている感じ
    private var presenter: UserDetailPresenterInput!
    
    func inject(presenter: UserDetailPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        presenter.viewDidLoad()
    }
    
    // ↓ 実質ここはStoryBoardとの紐付け
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    // ↑
   
}

// UserDetailPresenterの結果を使って画面をいじる
extension UserDetailViewController: UserDetailPresenterOutput {
    func updateUsername(_ username: String) {
        self.label.text = username
    }
}
