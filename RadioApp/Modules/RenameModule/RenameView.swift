//
//  RenameView.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit
import SnapKit

class RenameView: UIView{
    
    private let colorBack = UIColor(red: 31/255, green: 29/255, blue: 43/255, alpha: 1.0)
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = .background
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var pencilBackView: UIView = {
        let view = UIView()
        view.backgroundColor = colorBack
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var reinstallImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = User.shared.name ?? "User"
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = User.shared.email
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackUnderImage: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(emailLabel)
        
        return stack
    }()
    
    lazy var backViewNameTextField: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var textFieldNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Name"
        label.font = Font.getFont(.displayMedium, size: 14)
        label.backgroundColor = colorBack
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var textFieldName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Write new name"
        tf.setPlaceholderColor(.gray, textField: tf)
        tf.textColor = .white
        return tf
    }()
    
    lazy var backViewEmailTextField: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var textFieldEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = Font.getFont(.displayMedium, size: 14)
        label.backgroundColor = colorBack
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var textFieldEmail: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Write new Email"
        tf.setPlaceholderColor(.gray, textField: tf)
        tf.textColor = .white
        return tf
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save changes", for: .normal)
        button.titleLabel?.font = Font.getFont(.displayMedium, size: 16)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        
        button.backgroundColor = UIColor(red: 5/255, green: 216/255, blue: 232/255, alpha: 1.0)
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        constraintsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RenameView {
    func setupUI(){
        addSubview(backView)
        backView.addSubview(backgroundImage)
        backgroundImage.addSubview(avatarImage)
        backgroundImage.addSubview(avatarView)
        backgroundImage.addSubview(stackUnderImage)
        backgroundImage.addSubview(backViewNameTextField)
        backgroundImage.addSubview(backViewEmailTextField)
        backgroundImage.addSubview(saveButton)
    
        avatarView.addSubview(pencilBackView)
        pencilBackView.addSubview(reinstallImageButton)
        
        backViewNameTextField.addSubview(textFieldNameLabel)
        backViewNameTextField.addSubview(textFieldName)
        
        backViewEmailTextField.addSubview(textFieldEmailLabel)
        backViewEmailTextField.addSubview(textFieldEmail)
    }
    
    func constraintsUI() {
        backView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading)
            make.trailing.equalTo(backView.snp.trailing)
            make.top.equalTo(backView.snp.top)
            make.bottom.equalTo(backView.snp.bottom)
        }
    
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(backView.safeAreaLayoutGuide.snp.top).inset(20)
            make.width.height.equalTo(80)
            make.centerX.equalTo(backView.snp.centerX)
        }
        
        avatarView.snp.makeConstraints { make in
            make.top.equalTo(backView.safeAreaLayoutGuide.snp.top).inset(20)
            make.width.height.equalTo(90)
            make.centerX.equalTo(backView.snp.centerX)
        }
        
        pencilBackView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.trailing.equalTo(avatarView.snp.trailing).inset(1)
            make.bottom.equalTo(avatarView.snp.bottom).inset(1)
        }
        
        reinstallImageButton.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.centerX.equalTo(pencilBackView.snp.centerX)
            make.centerY.equalTo(pencilBackView.snp.centerY)
        }
        
        stackUnderImage.snp.makeConstraints { make in
            make.centerX.equalTo(backView.snp.centerX)
            make.top.equalTo(avatarImage.snp.bottom).offset(15)
        }
        
        backViewNameTextField.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading).inset(30)
            make.trailing.equalTo(backView.snp.trailing).inset(30)
            make.height.equalTo(55)
            make.top.equalTo(stackUnderImage.snp.bottom).offset(50)
        }
        
        textFieldNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backViewNameTextField.snp.top).inset(-7)
            make.leading.equalTo(backViewNameTextField.snp.leading).inset(15)
        }
        
        textFieldName.snp.makeConstraints { make in
            make.leading.equalTo(backViewNameTextField.snp.leading).inset(10)
            make.height.equalToSuperview()
        }
        
        backViewEmailTextField.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading).inset(30)
            make.trailing.equalTo(backView.snp.trailing).inset(30)
            make.height.equalTo(55)
            make.top.equalTo(backViewNameTextField.snp.bottom).offset(40)
        }
        textFieldEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(backViewEmailTextField.snp.top).inset(-7)
            make.leading.equalTo(backViewEmailTextField.snp.leading).inset(15)
        }
        
        textFieldEmail.snp.makeConstraints { make in
            make.leading.equalTo(backViewEmailTextField.snp.leading).inset(10)
            make.height.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading).inset(30)
            make.trailing.equalTo(backView.snp.trailing).inset(30)
            make.height.equalTo(55)
            make.top.equalTo(backViewEmailTextField.snp.bottom).offset(40)
        }
        
    }
}

extension UITextField{
    func setPlaceholderColor(_ color: UIColor, textField: UITextField){
        guard let placeholderText = textField.placeholder else {return}
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}
