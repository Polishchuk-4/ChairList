//
//  CellPhoto.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 29.06.2022.
//

import UIKit

class CellPhoto: UITableViewCell {
    var imgView: UIImageView!
    var buttonLibrary: UIButton!
    var buttonCamera: UIButton!
    
    private static let heightImgView: CGFloat = 180
    private static var heightButton: CGFloat {
        return self.heightImgView / 3
    }
    static var height: CGFloat {
        return CellPhoto.heightImgView + CellPhoto.heightButton + CGFloat.offset * 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createImgView()
        self.createButtonLibrary()
        self.createButtonCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImgView() {
        self.imgView = UIImageView.init()
        self.imgView.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.imgView.frame.size.height = CellPhoto.heightImgView
        self.imgView.frame.origin = CGPoint.init(x: CGFloat.offset, y: CGFloat.offset)
        self.imgView.backgroundColor = .systemGray3
        self.contentView.addSubview(self.imgView)
    }
    
    private func createButtonLibrary() {
        self.buttonLibrary = UIButton.init()
        self.buttonLibrary.frame.size.width = UIScreen.main.bounds.width / 2 - CGFloat.offset * 1.5
        self.buttonLibrary.frame.size.height = CellPhoto.heightButton
        self.buttonLibrary.frame.origin.x = CGFloat.offset
        self.buttonLibrary.frame.origin.y = CellPhoto.heightImgView + CGFloat.offset * 2
        self.contentView.addSubview(buttonLibrary)
        let image = "photo.on.rectangle".getSymbol(pointSize: CellPhoto.heightButton * 0.6, weight: .light)
        self.buttonLibrary.tintColor = .white
        self.buttonLibrary.backgroundColor = .blue
        self.buttonLibrary.setImage(image, for: .normal)
    }
    
    private func createButtonCamera() {
        self.buttonCamera = UIButton.init()
        self.buttonCamera.frame.size = self.buttonLibrary.frame.size
        self.buttonCamera.frame.origin.x = UIScreen.main.bounds.width / 2 + CGFloat.offset / 2
        self.buttonCamera.frame.origin.y = self.buttonLibrary.frame.origin.y
        self.contentView.addSubview(self.buttonCamera)
        let image = "camera".getSymbol(pointSize: CellPhoto.heightButton * 0.6, weight: .light)
        self.buttonCamera.tintColor = .white
        self.buttonCamera.backgroundColor = .blue
        self.buttonCamera.setImage(image, for: .normal)
    }
}
