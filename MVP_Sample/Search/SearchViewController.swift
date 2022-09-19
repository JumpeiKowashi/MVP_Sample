//
//  ViewController.swift
//  MVP_Sample
//
//  Created by Jumpei Kowashi on 2022/09/18.
//

import UIKit

// Viewにあたる
class SearchViewController: UIViewController {
    
    private var presenter: SearchUserPresenterInput!
    
    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }
    
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 4
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 0.5
        tf.placeholder = "検索"
        tf.addTarget(SearchViewController.self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return tf
    }()
    
    let tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
                
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @objc func textFieldEditingChanged(sender: UITextField) {
        guard let text = sender.text else{return}
        presenter?.didTapSearchButton(text: text)
    }
}



extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.user(forRow: indexPath.row)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}


extension SearchViewController: SearchUserPresenterOutput {
    func updateUsers(_ users: [String]) {
        tableView.reloadData()
    }
    
    func transitionToUserDetail(userName: String) {
        let controller = UserDetailViewController()
        let model = UserDetailModel(username: userName)
        let userDetailPresenter = UserDetailPresenter(usernamme: userName, view: controller, model: model)
        controller.inject(presenter: userDetailPresenter)
        
        
        present(controller, animated: true)
    }
}
