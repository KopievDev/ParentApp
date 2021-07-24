//
//  ChildrenCell.swift
//  ParentApp
//
//  Created by Ivan Kopiev on 23.07.2021.
//

import UIKit

class ChildrenCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "Cell"
    private let view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemTeal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ivan - 6 лет"
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.backgroundColor = UIColor(red: 0.988, green: 0.79, blue: 0.79, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isUserInteractionEnabled = true
        return button
    }()
    
    weak var delegate: ChildrenCellDelegate?
    
    var myIndex: Int?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setUp() {
        contentView.addSubview(view)
        view.addSubview(nameLabel)
        view.addSubview(removeButton)
        createConstraints()
        removeButton.addTarget(self, action: #selector(didTap(button:)), for: .touchUpInside)

    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            removeButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            removeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            removeButton.heightAnchor.constraint(equalToConstant: 48),
            removeButton.widthAnchor.constraint(equalToConstant: 80),
            
        ])
    }
    
    func configureCell(with person: Person, index: Int) {
        nameLabel.text = "\(person.name) - \(person.getAge())"
        myIndex = index
    }
    
    private func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn) {
            viewToAnimate.transform = .identity
            
        }
    }
    
    @objc private func didTap(button: UIButton) {
        animateView(button)
        guard let index = myIndex else {
            return
        }
        delegate?.didTapButton(on: index)
    }
}

