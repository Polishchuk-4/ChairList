//
//  CellSwitch.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 29.06.2022.
//

import UIKit

class CellSwitch: UITableViewCell {
    var label: UILabel!
    var switc_h: UISwitch!
    static let height: CGFloat = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createLabel()
        self.createSwitc_h()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel() {
        self.label = UILabel.init()
        self.label.frame.size.width = UIScreen.main.bounds.width / 3
        self.label.frame.size.height = CellTextField.height
        self.label.frame.origin.x = CGFloat.offset
        self.label.center.y = CellSwitch.height / 2
        self.label.font = UIFont.systemFont(ofSize: 20)
        self.contentView.addSubview(self.label)
    }
    
    private func createSwitc_h() {
        self.switc_h = UISwitch.init()
        self.switc_h.frame.origin.x = UIScreen.main.bounds.width - self.switc_h.frame.width - CGFloat.offset
        self.switc_h.center.y = CellSwitch.height / 2
        self.contentView.addSubview(self.switc_h)
    }
}
