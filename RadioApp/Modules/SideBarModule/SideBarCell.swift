//
//  SideBarCell.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit
import SnapKit

final class SideBarCell: UITableViewCell {

    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        label.textColor = .white
        return label
    }()

    private let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()

    private let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.5
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        circleView.backgroundColor = selected ? UIColor(red: 5/255.0, green: 216/255.0, blue: 232/255.0, alpha: 1) : .clear
    }
}

private extension SideBarCell {
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(circleView)
        contentView.addSubview(vStack)
    }

    func setupConstraints() {
        vStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(40)
        }
        label.snp.makeConstraints { make in
            make.width.equalTo(vStack.snp.height)
        }
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(15)
        }
    }
}
