//
//  FavoriteChair.swift
//  Copy(2)
//
//  Created by Denis Polishchuk on 03.07.2022.
//

import UIKit

class FavoriteChairVC: UITableViewController {
    var chairs: [Chair] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.chairs = CoreDataManager.shared.getFavoriteChairs()
        CoreDataManager.shared.saveContext()
        tableView.reloadData()
    }
    
    private func settingNavBar() {
        self.navigationItem.title = "Favorite chair"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDataSource -
extension FavoriteChairVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chairs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idCell = "favorite"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? CellChair
        if cell == nil {
            cell = CellChair.init(style: .value1, reuseIdentifier: idCell)
            cell?.favoritesButton.addTarget(self, action: #selector(deleteChair(button:)), for: .touchUpInside)
        }
        let chair = self.chairs[indexPath.row]
        if let photoData = chair.photo {
            cell!.imgView.image = UIImage.init(data: photoData)
            cell?.imgView.contentMode = .scaleAspectFill
            cell?.imgView.clipsToBounds = true
        } else {
            cell?.imgView.image = "photo".getSymbol(pointSize: cell!.imgView.frame.height, weight: .light)
            cell?.imgView.contentMode = .scaleAspectFit
        }
        cell?.labelname.text = chair.name
        if chair.isWheels == true {
            cell?.labelIsWheels.text = "With wheels"
        } else {
            cell?.labelIsWheels.text = "Witout wheels"
        }
        for i in 0 ..< cell!.rateImgView.count {
            let star = cell?.rateImgView[i]
            if i < chair.rate {
                star?.image = "star.fill".getSymbol(pointSize: star!.frame.height * 0.6, weight: .light)
            } else {
                star?.image = "star".getSymbol(pointSize: star!.frame.height * 0.6, weight: .light)
            }
        }
        let image = "heart.fill".getSymbol(pointSize: cell!.favoritesButton.frame.height, weight: .light)
        cell?.favoritesButton.setImage(image, for: .normal)
        return cell!
    }
}

//MARK: - UITableViewDelegate -
extension FavoriteChairVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellChair.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC.init()
        let chair = self.chairs[indexPath.row]
        vc.chair = chair
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Favorite -
extension FavoriteChairVC {
    @objc func deleteChair(button: UIButton) {
        let contentView = button.superview!
        let cell = contentView.superview as! CellChair
        let indexPath = tableView.indexPath(for: cell)
        let chair = self.chairs[indexPath!.row]
        chair.isFavorite = false
        CoreDataManager.shared.saveContext()
        self.chairs = CoreDataManager.shared.getFavoriteChairs()
        tableView.reloadData()
    }
}
