//
//  ParentView.swift
//  ParentApp
//
//  Created by Ivan Kopiev on 23.07.2021.
//

import UIKit

class ParentView: UIView {
    //MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите свои данные"
        return label
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 22)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "ФИО"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.accessibilityIdentifier = "name"
        return tf
    }()
    
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 22)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Возраст"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.accessibilityIdentifier = "age"
        return tf
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.backgroundColor = UIColor(red: 0.988, green: 0.79, blue: 0.79, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(animateView(_:)), for: .touchUpInside)
        return button
    }()

    let childrenTableView: UITableView = {
        let tv = UITableView()
        tv.register(ChildrenCell.self, forCellReuseIdentifier: ChildrenCell.identifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func setUp() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(ageTextField)
        addSubview(nameLabel)
        addSubview(addButton)
        addSubview(childrenTableView)
        createConstraints()
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
        
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            nameTextField.bottomAnchor.constraint(equalTo: ageTextField.topAnchor, constant: -16),
            
            ageTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            ageTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            ageTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            ageTextField.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -16),
            
            nameLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            nameLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16),

            addButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 48),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor),
            
            childrenTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16),
            childrenTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            childrenTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            childrenTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
    
    // MARK: - Selectors
    @objc private func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn) {
            viewToAnimate.transform = .identity
            
        }
    }
}

