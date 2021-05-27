//
//  SMSConfirmationViewController.swift
//  GryadkiAdminApp
//
//  Created by Bakdaulet Myrzakerov on 26.05.2021.
//

import UIKit

class SMSConfirmationViewController: UIViewController {
    var logoImageView: UIImageView = {
        var image = UIImageView(image: UIImage(named: "green gryadki"))
        return image
    }()
    var smsCodeLabel: UILabel = {
        var label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textColor = .darkTextColor
            label.text = "Смс код отправлен на Ваш номер"
        
        return label
    }()
    var exparationDateLabel: UILabel = {
        var label = UILabel()
            label.text = "Код истекает через: "
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textColor = .darkTextColor
        
        return label
    }()
    var codeConfirmation = ConfirmationCodeView()
    var nextButton = MainButton(text: "Подтвердить")
    var sendAgainButton: UIButton = {
        var button = UIButton()
        button.setTitle("выслать заново", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.lightTextColor, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackgroundColor
        setupView()
        nextButton.addTarget(self, action: #selector(nextTarget), for: .touchUpInside)
    }
    @objc func nextTarget() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    func setupView() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(60)
        }
        view.addSubview(smsCodeLabel)
        smsCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
        view.addSubview(codeConfirmation)
        codeConfirmation.snp.makeConstraints { make in
            make.top.equalTo(smsCodeLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(340)
        }
        view.addSubview(exparationDateLabel)
        exparationDateLabel.snp.makeConstraints { make in
            make.top.equalTo(codeConfirmation.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(exparationDateLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(330)
            make.height.equalTo(45)
        }
        view.addSubview(sendAgainButton)
        sendAgainButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(16)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
    }
}

