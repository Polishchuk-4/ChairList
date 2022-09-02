//
//  ViewController.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 29.06.2022.
//

import UIKit

class ChairListVC: UITableViewController {
    var chairs: [Chair] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.chairs = CoreDataManager.shared.getChairs()
        self.tableView.reloadData()
    }
    
    private func settingNavBar() {
        self.navigationItem.title = "Chair list"
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(goToDetailVC)), UIBarButtonItem.init(image: "heart".getSymbol(pointSize: 20, weight: .light), style: .plain, target: self, action: #selector(goToFavoriteChairVC))]
    }
    
    @objc func goToDetailVC() {
        let detailVC = DetailVC.init()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.chair = CoreDataManager.shared.createChair()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func goToFavoriteChairVC() {
        let vc = FavoriteChairVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TableViewDataSource -
extension ChairListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chairs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idCell = "chair"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? CellChair
        if cell == nil {
            cell = CellChair.init(style: .value1, reuseIdentifier: idCell)
            cell?.favoritesButton.addTarget(self, action: #selector(chooseFavoriteChair(button:)), for: .touchUpInside)
        }
        let chair = self.chairs[indexPath.row]
        if let photoData = chair.photo {
            cell?.imgView.image = UIImage.init(data: photoData)
            cell?.imgView.contentMode = .scaleAspectFill
            cell?.imgView.clipsToBounds = true
        } else {
            let image = "photo".getSymbol(pointSize: cell!.imgView.frame.height * 0.8, weight: .light)
            cell?.imgView.image = image
            cell?.imgView.contentMode = .scaleAspectFit
        }
        cell?.labelname.text = chair.name
        if chair.isWheels == true {
            cell?.labelIsWheels.text = "With wheels"
        } else {
            cell?.labelIsWheels.text = "Without wheels"
        }
        
        for i in 0 ..< cell!.rateImgView.count {
            let imgView = cell!.rateImgView[i]
            if imgView.tag <= chair.rate {
                let image = "star.fill".getSymbol(pointSize: 35, weight: .light)
                imgView.image = image
            } else {
                let image = "star".getSymbol(pointSize: 35, weight: .light)
                imgView.image = image
            }
        }
        
        if chair.isFavorite == false {
            let image = "heart".getSymbol(pointSize: 35, weight: .light)
            cell?.favoritesButton.setImage(image, for: .normal)
            cell?.favoritesButton.tintColor = .white
        } else {
            let image = "heart.fill".getSymbol(pointSize: 35, weight: .light)
            cell?.favoritesButton.setImage(image, for: .normal)
            cell?.favoritesButton.tintColor = .red
        }
        
        return cell!
    }
}

//MARK: - TableViewDelegate -
extension ChairListVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellChair.height
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let chair = self.chairs.remove(at: indexPath.row)
        CoreDataManager.shared.deleteObjc(chair: chair)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chair = self.chairs[indexPath.row]
        let vc = DetailVC.init()
        vc.chair = chair
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - FavoriteButton -
extension ChairListVC {
    @objc private func chooseFavoriteChair(button: UIButton) {
        let contentView = button.superview!//получаем view на которой лежит кнопка
        let cell = contentView.superview as! CellChair
        let indexPath = tableView.indexPath(for: cell)!
        let chair = self.chairs[indexPath.row]
        
        if chair.isFavorite == false {
            chair.isFavorite = true
        } else {
            chair.isFavorite = false
        }
        tableView.reloadData()
    }
}



