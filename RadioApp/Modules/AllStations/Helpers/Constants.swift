//
//  Constants.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

import UIKit

struct K {
    static let appName = "Hello Mark"
    static let screenName = "All stations"
    static let placeholder = "Search radio station"
    static let votes = "votes"
}

struct Colors {
    static let background = UIColor(red: 0.00, green: 0.00, blue: 0.16, alpha: 1.00)
    static let teal = UIColor(red: 0.02, green: 0.85, blue: 0.91, alpha: 1.00)
    static let indigo = UIColor(red: 0.00, green: 0.34, blue: 0.47, alpha: 1.00)
    static let light = UIColor(red: 0.82, green: 0.98, blue: 1.00, alpha: 1.00)
    static let pink = UIColor(red: 1.00, green: 0.16, blue: 0.43, alpha: 1.00)
    static let white = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    static let grey = UIColor(red: 0.32, green: 0.32, blue: 0.44, alpha: 1.00)
    static let anotherGray = UIColor(red: 50/255, green: 50/255, blue: 78/255, alpha: 1)
}


struct Search {
    static let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static let iconPadding: UIView = {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        icon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        paddingView.addSubview(icon)
        return paddingView
    }()
    
    static let result: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static let resultPadding: UIView = {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        result.clipsToBounds = true
        result.frame = CGRect(x: -60, y: -25, width: 120, height: 120)
        paddingView.addSubview(result)
        return paddingView
    }()
    
}
