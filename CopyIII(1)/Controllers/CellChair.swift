//
//  CellChair.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 29.06.2022.
//

import UIKit

class CellChair: UITableViewCell {
    var imgView: UIImageView!
    var favoritesButton: UIButton!
    var labelname: UILabel!
    var labelIsWheels: UILabel!
    var rateImgView: [UIImageView] = []
    
    private static let heightImgView: CGFloat = 180
    private static let heightLabels: CGFloat = 40
    static var height: CGFloat {
        return CellChair.heightImgView + CellChair.heightLabels * 2 + CGFloat.offset * 4
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createimgView()
        self.createFavoriteButton()
        self.createLabelName()
        self.createLabelIsWheels()
        self.createRateImgView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createimgView() {
        self.imgView = UIImageView.init()
        self.imgView.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.imgView.frame.size.height = CellChair.heightImgView
        self.imgView.frame.origin = CGPoint.init(x: CGFloat.offset, y: CGFloat.offset)
        self.imgView.backgroundColor = .systemGray3
        self.contentView.addSubview(self.imgView)
    }
    
    private func createFavoriteButton() {
        self.favoritesButton = UIButton.init()
        self.favoritesButton.frame.size = CGSize.init(width: 35, height: 35)
        self.favoritesButton.frame.origin.x = self.imgView.frame.origin.x + self.imgView.frame.width - self.favoritesButton.frame.width - CGFloat.offset
        self.favoritesButton.frame.origin.y = self.imgView.frame.origin.y + CGFloat.offset
        let image = "heart".getSymbol(pointSize: 35, weight: .light)
        self.favoritesButton.setImage(image, for: .normal)
        self.favoritesButton.tintColor = .white
        self.contentView.addSubview(self.favoritesButton)
    }
    
    private func createLabelName() {
        self.labelname = UILabel.init()
        self.labelname.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.labelname.frame.size.height = CellChair.heightLabels
        self.labelname.frame.origin.x = CGFloat.offset
        self.labelname.frame.origin.y = CellChair.heightImgView + CGFloat.offset * 2
        self.labelname.font = UIFont.systemFont(ofSize: 30)
        self.contentView.addSubview(self.labelname)
    }
    
    private func createLabelIsWheels() {
        self.labelIsWheels = UILabel.init()
        self.labelIsWheels.frame.size.width = 180
        self.labelIsWheels.frame.size.height = CellChair.heightLabels
        self.labelIsWheels.frame.origin.x = CGFloat.offset
        self.labelIsWheels.center.y = CellChair.heightImgView + CellChair.heightLabels + CGFloat.offset * 3 + self.labelIsWheels.frame.height / 2
        self.labelIsWheels.font = UIFont.systemFont(ofSize: 25)
        self.contentView.addSubview(self.labelIsWheels)
    }
    
    private func createRateImgView() {
        let widthStar: CGFloat = 30
        let widthForStars: CGFloat = widthStar * 5 + CGFloat.offset * 4
        let positionFirstStar_X: CGFloat = UIScreen.main.bounds.width - CGFloat.offset - widthForStars
        
        for i in 0 ..< 5 {
            let rateImgView = UIImageView.init()
            rateImgView.frame.size = CGSize.init(width: widthStar, height: widthStar)
            rateImgView.frame.origin.x = positionFirstStar_X + (rateImgView.frame.width + CGFloat.offset) * CGFloat(i)
            rateImgView.center.y = CellChair.heightImgView + CellChair.heightLabels + CGFloat.offset * 3 + rateImgView.frame.height / 2
            let image = "star".getSymbol(pointSize: 30, weight: .light)
            rateImgView.image = image
            rateImgView.tag = 1 + i
            rateImgView.tintColor = .blue
            self.rateImgView.append(rateImgView)
            self.contentView.addSubview(rateImgView)
        }
    }
}
