//
//  WelcomeViewController.swift
//  Unicorn
//
//  Created by Tomas Kohout on 25/03/2017.
//  Copyright © 2017 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    weak var imageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        
        let imageView = UIImageView(image: Asset.unicorn.image)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
        }
        self.imageView = imageView
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.Welcome.title
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = L10n.Welcome.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        let enableButton = UIButton()
        enableButton.setBackgroundImage(UIColor.unicornBlue.image(), for: .normal)
        enableButton.clipsToBounds = true
        enableButton.setTitleColor(.white, for: .normal)
        enableButton.setTitle(L10n.Welcome.enable, for: .normal)
        enableButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        enableButton.layer.cornerRadius = 10
        view.addSubview(enableButton)
        enableButton.snp.makeConstraints { (make) in
            //make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        let skipButton = UIButton()
        skipButton.setTitleColor(.unicornLightGray, for: .normal)
        skipButton.setTitleColor(.unicornGray, for: .highlighted)
        skipButton.setTitle(L10n.Welcome.skip, for: .normal)
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { (make) in
            make.top.equalTo(enableButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: { _ in
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}
