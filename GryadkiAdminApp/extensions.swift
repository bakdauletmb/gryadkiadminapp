//
//  extensions.swift
//  GryadkiAdminApp
//
//  Created by Bakdaulet Myrzakerov on 26.05.2021.
//

import UIKit
extension UIColor {
    static let darkTextColor = #colorLiteral(red: 0.3137254902, green: 0.3333333333, blue: 0.3607843137, alpha: 1)
    static let lightTextColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    static let mainBackgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
    static let mainGreenColor = #colorLiteral(red: 0, green: 0.631372549, blue: 0.6039215686, alpha: 1)
}
enum InputTypes {
    case phone
    case plainText
    case secureText
    
    var isSecure: Bool {
        return .secureText == self
    }
}

enum InputViewTypes {
    case email
    case phone
    case iin
    case `default`
}


class InputView: UIView {
    
    //MARK: - Properties
    let inputType: InputTypes
    var placeholder: String
    private let icon: UIImage?
    var iconAction: (() -> ())?

    
    lazy var textField: UITextField = {
        let tf = UITextField()
            tf.layer.cornerRadius = 10
            tf.clipsToBounds = true
            tf.tag = 0
            tf.isSecureTextEntry = inputType.isSecure
            tf.borderStyle = .none
            tf.font = .systemFont(ofSize: 13, weight: .regular)
            tf.textColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 0.9)
            tf.backgroundColor = .white
            tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [
                                                            NSAttributedString.Key.foregroundColor:  UIColor.lightTextColor,
                                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)])
            //margin left
            tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
            tf.leftViewMode = .always

        return tf
    }()
    
    lazy var phoneTextField: PhoneTextField = {
        let tf = PhoneTextField()
            tf.tag = 1
            tf.borderStyle = .none
            tf.font = .systemFont(ofSize: 24, weight: .medium)
            tf.textColor = #colorLiteral(red: 0.3058823529, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            tf.backgroundColor = .white
            tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [
                                                        NSAttributedString.Key.foregroundColor: UIColor.lightTextColor,
                                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)])
            //margin left
             tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
             tf.leftViewMode = .always
        
        return tf
    }()
    
    lazy var iconView: UIImageView = {
        let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = icon
            iv.isUserInteractionEnabled = true
        
        return iv
    }()


    //MARK: - Initialization
    init(inputType: InputTypes, placeholder: String, icon: UIImage? = nil) {
        self.inputType = inputType
        self.placeholder = placeholder
        self.icon = icon
        super.init(frame: .zero)
        
        setupViews()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setupViews() {

        self.layer.cornerRadius = 8
        
        if inputType == .phone {
            self.addSubview(self.phoneTextField)
            self.phoneTextField.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        } else {
            self.addSubview(self.textField)
            self.textField.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
            addSubview(iconView)
            iconView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-10)
                make.height.width.equalTo(23)
            }

    }
    
    private func setupGesture() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTarget))
        iconView.addGestureRecognizer(tapGesture)
        
    }
    @objc func iconTarget() -> Void {
        iconAction?()
    }


}

class PhoneTextField: UITextField {
    
    //MARK:- Preasure
    
    var didBeginEditing: (() -> ())?
    var didEndEditing: (() -> ())?
    
    fileprivate var label: UILabel = {
        let label = UILabel()
        label.text = ""
        
        return label
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        layer.cornerRadius = 10
        
        leftView = label
        leftViewMode = .always
        rightViewMode = .always
        font = UIFont.boldSystemFont(ofSize: 15)
        text = "+7"
        delegate = self
        keyboardType = .decimalPad
    }
    
}
//MARK:- UITextFieldDelegate
extension PhoneTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text!
        let spaceIndex = [2, 6, 10, 13]

        if text == "+7" && string == "" {
            return false
        }

        if text.count == 16 && string != "" {
            return false
        }

        if spaceIndex.contains(textField.text!.count) && string != "" {
            textField.text!.append(" ")
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didBeginEditing?()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing?()
    }
}

class MainButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .mainGreenColor
        self.layer.cornerRadius = 15
        self.addTarget(self, action: #selector(targetAction), for: .touchUpInside)
        

    }
    func showLabel(notificationCount: String = "12") {
        addSubview(notificationsCountLabel)
        notificationsCountLabel.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.right.equalToSuperview()
            make.top.equalTo(-6)
            make.right.equalTo(12)
        }
        notificationsCountLabel.text = notificationCount
    }
    var tapAction: (()->())?
    var notificationsCountLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .systemRed
        label.text = "12"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        
        return label
    }()
    @objc func targetAction() {
        self.tapAction?()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class ConfirmationCodeView: UIView {
    lazy var firstInputView : UITextField = {
        var text = UITextField()
            text.textColor = .mainGreenColor
            text.layer.borderColor = UIColor.mainGreenColor.cgColor
            text.layer.borderWidth = 2
            text.backgroundColor = .white
            text.layer.cornerRadius = 8
            text.keyboardType = .numberPad
            text.textAlignment = .center
            text.font = .systemFont(ofSize: 34, weight: .medium)
            text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
            text.layer.borderWidth = 2
        return text
    }()
    var onFourthInputViewChange : (()->())?
    
    lazy var secondInputView : UITextField = {
        var text = UITextField()
            text.layer.borderWidth = 2
            text.textColor = .mainGreenColor
            text.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            text.backgroundColor = .white
            text.layer.cornerRadius = 8
            text.keyboardType = .numberPad
            text.textAlignment = .center
            text.font = .systemFont(ofSize: 34, weight: .medium)
            text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        
        return text
    }()
    lazy var thirdInputView : UITextField = {
        var text = UITextField()
            text.layer.borderWidth = 2
            text.textColor = .mainGreenColor
            text.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            text.backgroundColor = .white
            text.layer.cornerRadius = 8
            text.keyboardType = .numberPad
            text.textAlignment = .center
            text.font = .systemFont(ofSize: 34, weight: .medium)
            text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        
        return text
    }()
    lazy var fourthInputView : UITextField = {
        var text = UITextField()
            text.layer.borderWidth = 2
            text.layer.borderWidth = 2
            text.textColor = .mainGreenColor
            text.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            text.backgroundColor = .white
            text.layer.cornerRadius = 8
            text.keyboardType = .numberPad
            text.textAlignment = .center
            text.font = .systemFont(ofSize: 34, weight: .medium)
            text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
            text.delegate = self
        
        return text
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupViews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubview(firstInputView)
            firstInputView.snp.makeConstraints { (make) in
                make.top.left.equalToSuperview()
                make.width.height.equalTo(77)
            }
        addSubview(secondInputView)
            secondInputView.snp.makeConstraints { (make) in
                make.top.width.height.equalTo(firstInputView)
                make.left.equalTo(firstInputView.snp.right).offset(12)
            }
        addSubview(thirdInputView)
            thirdInputView.snp.makeConstraints { (make) in
                make.top.width.height.equalTo(firstInputView)
                make.left.equalTo(secondInputView.snp.right).offset(12)
            }
        addSubview(fourthInputView)
            fourthInputView.snp.makeConstraints { (make) in
                make.top.width.height.equalTo(firstInputView)
                make.left.equalTo(thirdInputView.snp.right).offset(12)
            }
    }
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        firstInputView.layer.borderColor = UIColor.white.cgColor
        secondInputView.layer.borderColor = UIColor.white.cgColor
        thirdInputView.layer.borderColor = UIColor.white.cgColor
        fourthInputView.layer.borderColor = UIColor.white.cgColor
        if text?.count == 1 {
            switch textField {
            case firstInputView:
                secondInputView.becomeFirstResponder()
                secondInputView.layer.borderColor = UIColor.mainGreenColor.cgColor
            case secondInputView:
                thirdInputView.becomeFirstResponder()
                thirdInputView.layer.borderColor = UIColor.mainGreenColor.cgColor
            case thirdInputView:
                fourthInputView.becomeFirstResponder()
                fourthInputView.layer.borderColor = UIColor.mainGreenColor.cgColor
            case fourthInputView:
                fourthInputView.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case secondInputView:
                firstInputView.becomeFirstResponder()
            case thirdInputView:
                secondInputView.becomeFirstResponder()
            case fourthInputView:
                thirdInputView.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
}


extension ConfirmationCodeView : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onFourthInputViewChange?()
    }
    
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

