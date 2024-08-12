//
//  LanguageView.swift
//  RadioApp
//
//  Created by Drolllted on 12.08.2024.
//

import UIKit
import SnapKit

class LanguageView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        constraintsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension LanguageView{
    func setupUI(){
        addSubview(backView)
        backView.addSubview(backgroundImage)
    }
    
    func constraintsUI(){
        backView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
            make.top.equalTo(self.snp.top)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading)
            make.trailing.equalTo(backView.snp.trailing)
            make.bottom.equalTo(backView.snp.bottom)
            make.top.equalTo(backView.snp.top)
        }
    }
}
