//
//  OnboardingVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

final class OnboardingMainVC: UIViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .background
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private var gradientLayer: CAGradientLayer {
        let element = CAGradientLayer()
        element.frame = view.bounds
        element.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        element.startPoint = CGPoint(x: 0.5, y: 1.0)
        element.endPoint = CGPoint(x: 0.5, y: 0.0)
        return element
    }
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .center
        element.spacing = 5
        element.distribution = .fillProportionally
        return element
    }()
    
    private lazy var starImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "star.fill")
        element.contentMode = .scaleAspectFit
        element.tintColor = .black
        return element
    }()
    
    private lazy var firstHeaderLabel: UILabel = {
        let element = UILabel()
        element.text = "100k +"
        element.font = .systemFont(ofSize: 20, weight: .bold)
        element.textColor = .white
        return element
    }()
    
    private lazy var secondHeaderLabel: UILabel = {
        let element = UILabel()
        element.text = "Premium recipes"
        element.font = .systemFont(ofSize: 20, weight: .regular)
        element.textColor = .white
        return element
    }()
    
    private lazy var getStartedButton: UIButton = {
        let element = UIButton()
        element.setTitle("Get started", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        element.backgroundColor = UIColor(named: "buttonColor")
        element.layer.cornerRadius = 40
        element.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        return element
    }()
    
    private lazy var findBestLabel: UILabel = {
        let element = UILabel()
        element.text = "Find best recipes for cooking"
        element.font = .systemFont(ofSize: 20, weight: .regular)
        element.textColor = .white
        return element
    }()
    
    private lazy var bestRecipeLabel: UILabel = {
        let element = UILabel()
        element.text = "Best \n Recipe"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 70, weight: .bold)
        element.textColor = .white
        element.numberOfLines = 0
        return element
    }()
    
    //    weak var coordinator: OnboardingCoordinator!
    //
    //    init(coordinator: OnboardingCoordinator!) {
    //        super.init(nibName: nil, bundle: nil)
    //        self.coordinator = coordinator
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.layer.addSublayer(gradientLayer)
        view.addSubview(headerStackView)
        view.addSubview(getStartedButton)
        view.addSubview(findBestLabel)
        view.addSubview(bestRecipeLabel)
        
        headerStackView.addArrangedSubview(starImageView)
        headerStackView.addArrangedSubview(firstHeaderLabel)
        headerStackView.addArrangedSubview(secondHeaderLabel)
    }
    // MARK: - Selector methods
    @objc private func getStartedButtonTapped() {
        print("getStartedButtonTapped")
    }
}

// MARK: - Setup Constraints
extension OnboardingMainVC {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(80)
            make.width.equalTo(view.frame.width / 2)
            make.centerX.equalToSuperview()
        }
        
        findBestLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(getStartedButton).inset(-60)
        }
        
        bestRecipeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(findBestLabel).inset(-190)
        }
    }
}
