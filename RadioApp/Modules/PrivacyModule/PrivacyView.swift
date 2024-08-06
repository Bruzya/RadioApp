//
//  PrivacyView.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit
import SnapKit

class PrivacyView: UIView {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = .background
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    func createPrivacyPoliticalLabels(titleName: String, privacyLabel: String) -> UIStackView {
        
        lazy var titleNameString: UILabel = {
            let label = UILabel()
            label.text = titleName
            label.font = Font.getFont(.displayBold, size: 18)
            label.textColor = .white
            label.textAlignment = .left
            label.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
            
            return label
        }()
        
        lazy var firstPrivacyLabel: UILabel = {
            let label = UILabel()
            label.text = privacyLabel
            label.font = Font.getFont(.displayRegular, size: 16)
            label.textColor = .gray
            label.textAlignment = .left
            label.numberOfLines = 7
            
            return label
        }()
        
        lazy var secondPrivacyLabel: UILabel = {
            let label = UILabel()
            label.text = privacyLabel
            label.font = Font.getFont(.displayRegular, size: 16)
            label.textColor = .gray
            label.textAlignment = .left
            label.numberOfLines = 7
            return label
        }()
        
        lazy var stackPolitical: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 1
            stack.alignment = .leading
            
            stack.addArrangedSubview(titleNameString)
            stack.addArrangedSubview(firstPrivacyLabel)
            stack.addArrangedSubview(secondPrivacyLabel)
            
            return stack
        }()
        
        titleNameString.setContentHuggingPriority(.defaultHigh, for: .vertical)
        firstPrivacyLabel.setContentHuggingPriority(.required, for: .vertical)
        titleNameString.setContentHuggingPriority(.required, for: .vertical)
        
        return stackPolitical
    }
    
    lazy var stackMain: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createMainStack()
        
        setupUI()
        
        constraintsUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMainStack() {
        let stack1 = createPrivacyPoliticalLabels(titleName: "Terms", privacyLabel: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
        let stack2 = createPrivacyPoliticalLabels(titleName: "Privacy", privacyLabel: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
        
        stackMain.addArrangedSubview(stack1)
        stackMain.addArrangedSubview(stack2)
    }
    
}
extension PrivacyView{
    func setupUI() {
        addSubview(backView)
        backView.addSubview(backgroundImage)
        backgroundImage.addSubview(stackMain)
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
        
        stackMain.snp.makeConstraints { make in
            make.leading.equalTo(backgroundImage.snp.leading).inset(30)
            make.trailing.equalTo(backgroundImage.snp.trailing).inset(30)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(15)
            make.height.equalTo(615)
        }
    }
}
