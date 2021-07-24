//
//  ProtocolCell.swift
//  ParentApp
//
//  Created by Ivan Kopiev on 23.07.2021.
//

import Foundation

protocol ChildrenCellDelegate: AnyObject {
    func didTapButton(on index: Int)
}

