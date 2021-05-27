//
//  ViewController.swift
//  GryadkiAdminApp
//
//  Created by Bakdaulet Myrzakerov on 26.05.2021.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    var notificationsButton = MainButton(text: "Уведомления")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(notificationsButton)
        notificationsButton.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.bottom.equalTo(-40)
            make.left.equalTo(20)
        }
        self.view.backgroundColor = .mainBackgroundColor
        notificationsButton.showLabel()
        notificationsButton.tapAction = {
            self.navigationController?.pushViewController(NotificationsViewController(), animated: true)
        }
    }

}

