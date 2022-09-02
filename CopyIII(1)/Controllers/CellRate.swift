//
//  CellRate.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 29.06.2022.
//

import UIKit

class CellRate: UITableViewCell {
    var label: UILabel!
    var buttons: [UIButton] = []
    static let height: CGFloat = CellSwitch.height
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createLabel()
        self.createButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel() {
        self.label = UILabel.init()
        self.label.frame.size.width = 100
        self.label.frame.size.height = CellRate.height
        self.label.frame.origin.x = CGFloat.offset
        self.label.center.y = CellRate.height / 2
        self.label.font = UIFont.systemFont(ofSize: 20)
        self.contentView.addSubview(self.label)
    }
    
    private func createButtons() {
        let widthButton = CellRate.height * 0.6
        let widthForButtons = widthButton * 5 + CGFloat.offset * 4
        let positionFirstButton = UIScreen.main.bounds.width - widthForButtons - CGFloat.offset
        
        for i in 0 ..< 5 {
            let button = UIButton.init()
            button.frame.size.width = widthButton
            button.frame.size.height = widthButton
            button.center.y = CellRate.height / 2
            button.frame.origin.x = positionFirstButton + (button.frame.width + CGFloat.offset) * CGFloat(i)
            let image = "star".getSymbol(pointSize: button.frame.width * 0.8, weight: .light)
            button.setImage(image, for: .normal)
            button.tag = 1 + i
            self.buttons.append(button)
            self.contentView.addSubview(button)
        }
    }
}
