//
//  DetailVC.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 29.06.2022.
//

import UIKit

enum TypeCell: Int, CaseIterable {
    case photo
    case textField
    case switc_h
    case rate
}

class DetailVC: UITableViewController {
    var chair: Chair!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingDetailVC()
    }
    
    func settingDetailVC() {
        self.navigationItem.title = "Detail"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveDetailVC))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDetailVC))
    }
    
    @objc func saveDetailVC() {
        CoreDataManager.shared.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelDetailVC() {
        CoreDataManager.shared.persistentContainer.viewContext.reset()
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDataSource -
extension DetailVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TypeCell.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeCell = TypeCell.init(rawValue: indexPath.row) else { fatalError() }
        switch typeCell {
        case .photo: return self.createCellPhoto()
        case .textField: return self.createCellTextField()
        case .switc_h: return self.createSwitc_h()
        case .rate: return self.createRate()
        }
    }
    
    func createCellPhoto() -> CellPhoto {
        let idCell = "photo"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? CellPhoto
        if cell == nil {
            cell = CellPhoto.init(style: .value1, reuseIdentifier: idCell)
            cell?.buttonLibrary.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
            cell?.buttonCamera.addTarget(self, action: #selector(madePhoto), for: .touchUpInside)
            cell?.selectionStyle = .none
        }
        
        if let photoData = chair.photo {
            cell?.imgView.image = UIImage.init(data: photoData)
            cell?.imgView.contentMode = .scaleAspectFill
            cell?.imgView.clipsToBounds = true
        } else {
            let image = "photo".getSymbol(pointSize: cell!.imgView.frame.height * 0.8, weight: .light)
            cell?.imgView.image = image
            cell?.imgView.contentMode = .scaleAspectFit
        }
        
        return cell!
    }
    
    func createCellTextField() -> CellTextField {
        let id = "textField"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? CellTextField
        if cell == nil {
            cell = CellTextField.init(style: .value1, reuseIdentifier: id)
            cell?.selectionStyle = .none
            cell?.textField.delegate = self
        }
        cell?.textField.placeholder = "name"
        cell?.textField.text = chair.name
        return cell!
    }
    
    func createSwitc_h() -> CellSwitch {
        let idCell = "switc_h"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? CellSwitch
        if cell == nil {
            cell = CellSwitch.init(style: .value1, reuseIdentifier: idCell)
            cell?.switc_h.addTarget(self, action: #selector(isWheels(switc_h:)), for: .touchUpInside)
            cell?.selectionStyle = .none
        }
        if self.chair.isWheels == true {
            cell?.label.text = "With wheels"
        } else {
            cell?.label.text = "Without wheels"
        }
        cell?.switc_h.isOn = chair.isWheels
        return cell!
    }
    
    func createRate() -> CellRate {
        let idCell = "rate"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? CellRate
        if cell == nil {
            cell = CellRate.init(style: .value1, reuseIdentifier: idCell)
            cell?.selectionStyle = .none
            cell?.buttons.forEach({ button in
                button.addTarget(self, action: #selector(setRate(button:)), for: .touchUpInside)
            })
        }
        self.showRate(cell: cell!)
        cell?.label.text = "Rate" 
        return cell!
    }
}

//MARK: - UITableViewDelegate -
extension DetailVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let typeCell = TypeCell.init(rawValue: indexPath.row) else { fatalError() }
        switch typeCell {
        case .photo: return CellPhoto.height
        case .textField: return CellTextField.height
        case .switc_h: return CellSwitch.height
        case .rate: return CellRate.height
        }
    }
}

//MARK: - Image -
extension DetailVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @objc func choosePhoto() {
        let vc = UIImagePickerController.init()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func madePhoto() {
        let vc = UIImagePickerController.init()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let key = UIImagePickerController.InfoKey.editedImage
        let image = info[key] as! UIImage
        self.chair.photo = image.pngData()
        tableView.reloadData()
        self.dismiss(animated: true)
    }
}

//MARK: - TextField -
extension DetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.chair.name = textField.text
        tableView.reloadData()
    }
}

//MARK: - Switch -
extension DetailVC {
    @objc func isWheels(switc_h: UISwitch) {
        self.chair.isWheels = switc_h.isOn
        tableView.reloadData()
    }
}

//MARK: - Rate -
extension DetailVC {
    @objc func setRate(button: UIButton) {
        self.chair.rate = Int16(button.tag)
        tableView.reloadData()
    }
    
    func showRate(cell: CellRate) {
        for i in 0 ..< cell.buttons.count {
            let button = cell.buttons[i]
            if i < self.chair.rate {
                let imageStar = "star.fill".getSymbol(pointSize: button.frame.width * 0.8, weight: .light)
                button.setImage(imageStar, for: .normal)
            } else {
                let imageStar = "star".getSymbol(pointSize: button.frame.width * 0.8, weight: .light)
                button.setImage(imageStar, for: .normal)
            }
        }
    }
}

