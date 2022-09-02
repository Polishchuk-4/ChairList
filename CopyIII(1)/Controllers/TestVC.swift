//
//  TestVC.swift
//  CopyIII(1)
//
//  Created by Denis Polishchuk on 30.06.2022.
//

import UIKit

class TestVC: UIViewController {
    
//MARK: - Функции жизненного цикла контроллера -
    
// Эта функция запускается в момент создания view контроллера
    override func loadView() {
        super.loadView()
        print("loadView")
    }
// Эта функция запускается когда view уже создалась в ОП
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
// запускается перед показом view контроллера
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
// запускается когда view показалась на экране
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
// запускается перед уходом с контроллера
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
// запускается когда покинули контроллер
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
// запускается при изменениях на view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
    
}

