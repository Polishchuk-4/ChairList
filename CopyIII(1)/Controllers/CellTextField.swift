//
//  CellTextField.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 29.06.2022.
//

import UIKit

class CellTextField: UITableViewCell {
    var textField: UITextField!
    static let height: CGFloat = 75
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTextField() {
        self.textField = UITextField.init()
        self.textField.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.textField.frame.size.height = CellTextField.height - CGFloat.offset * 2
        self.textField.frame.origin = CGPoint.init(x: CGFloat.offset, y: CGFloat.offset)
        self.textField.backgroundColor = .systemGray6
        self.textField.layer.borderWidth = 0.7
        self.textField.layer.borderColor = UIColor.gray.cgColor
        self.textField.layer.cornerRadius = self.textField.frame.height / 2
        self.textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.textField.frame.height / 2, height: 0))
        self.textField.leftViewMode = .always
        self.contentView.addSubview(self.textField)
    }
}
