//
//  NotificationsViewController.swift
//  GryadkiAdminApp
//
//  Created by Bakdaulet Myrzakerov on 26.05.2021.
//

import UIKit
final class NotificationsViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NotificationsTableViewCell.self, forCellReuseIdentifier: "NotificationsTableViewCell")
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Задание", message: "Полить цветы и сделать что-то еще", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Перейти", style: .default) { (_) in
            
        }
        let cancel = UIAlertAction(title: "Уже сделано", style: .destructive) { (_) in
            
        }
        alert.addAction(cancel)
        alert.addAction(action)
        
            
        self.present(alert, animated: true) {
            
        }
    }
}

final class NotificationsTableViewCell: UITableViewCell {
    var notificationTextLabel: UILabel = {
        var label = UILabel()
        label.text = "Полить цветы и сделать что-то еще"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(notificationTextLabel)
        notificationTextLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
