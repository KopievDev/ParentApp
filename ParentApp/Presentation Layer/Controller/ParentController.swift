//
//  ParentController.swift
//  ParentApp
//
//  Created by Ivan Kopiev on 23.07.2021.
//

import UIKit

class ParentController: UIViewController {
    
    // MARK: - Properties
    lazy var parentView = ParentView(frame: self.view.frame)
    var childrens = [Person]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    // MARK: - Helpers
    func setUp() {
        title = "Parent App"
        view.addSubview(parentView)
        configureView()
    }
    
    func configureView() {
        
        parentView.addButton.addTarget(self, action: #selector(addChildren), for: .touchUpInside)
        parentView.childrenTableView.dataSource = self
        parentView.childrenTableView.delegate = self
        parentView.ageTextField.delegate = self
        parentView.nameTextField.delegate = self
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "Введите данные ребенка:", preferredStyle: .alert)
        alert.addTextField { tf in
            tf.placeholder = "Имя"
        }
        alert.addTextField { tf in
            tf.placeholder = "Возраст"
            tf.keyboardType = .decimalPad
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { action in
            
            guard let name =  alert.textFields?[0].text,
                  let age = Int(alert.textFields?[1].text ?? "0") else { return }
            if self.childrens.count <= 4 {
                if self.childrens.count == 4 {
                    self.parentView.addButton.isHidden = true
                }
                self.childrens.append(Person(name: name, age: age))
                self.parentView.childrenTableView.reloadData()
            }
            
        }))
        
        present(alert, animated: true)
    }
    
    func checkShowAddButton() {
        if childrens.count == 5 {
            self.parentView.addButton.isHidden = true
        } else {
            self.parentView.addButton.isHidden = false

        }
    }
    
    func removeChildren(at index: Int) {
        childrens.remove(at: index)
        parentView.childrenTableView.reloadData()
        checkShowAddButton()
    }
    // MARK: - Selectors
    @objc func addChildren() {
        showAlert()
        
    }
}

// MARK: - Extension TableView DataSource
extension ParentController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildrenCell.identifier, for: indexPath) as? ChildrenCell else { return UITableViewCell()}
        cell.delegate = self
        let children = childrens[indexPath.row]
        cell.configureCell(with: children, index: indexPath.row)
        return cell
    }
    
    
}
// MARK: - Extension TableView Delegate
extension ParentController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Удалить") {  (contextualAction, view, boolValue) in
            self.removeChildren(at: indexPath.row)
            
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
    
}
// MARK: - Extension ChildrenCellDelegate
extension ParentController: ChildrenCellDelegate {
    func didTapButton(on index: Int) {
        removeChildren(at: index)
    }
}
// MARK: - Extension UITextFieldDelegate
extension ParentController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var name = parentView.nameTextField.text,
              var age = parentView.ageTextField.text else {
            return true }
        
        if textField.accessibilityIdentifier == "name" {
            name += string
        } else {
            age += string
        }
        
        guard let numberAge = Int(age) else {
            parentView.nameLabel.text = ""
            return true
        }
        
        let person = Person(name: name, age: numberAge)
        parentView.nameLabel.text = "\(person.name), Вам \(person.getAge())"
        
        return true
    }
}

