//
//  Person.swift
//  ParentApp
//
//  Created by Ivan Kopiev on 23.07.2021.
//

import Foundation

struct Person {
    let name: String
    let age: Int
    
    func getAge()-> String {
        if age % 10 == 1, age != 11 {
            return "\(age) год"
        } else if age % 10 == 2 && age != 12 ||
                    age % 10 == 3 && age != 13 ||
                    age % 10 == 4 && age != 14 {
            return "\(age) года"
        }
        return "\(age) лет"
    }
}
