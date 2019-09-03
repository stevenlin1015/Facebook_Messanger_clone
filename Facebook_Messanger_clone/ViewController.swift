//
//  ViewController.swift
//  Facebook_Messanger_clone
//
//  Created by Steven on 2019/9/2.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit



class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    
    var messages: [Message]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        
        if let message = messages?[indexPath.item] {
            cell.message = message
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

}

class MessageCell: BaseCell {
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                timeLabel.text = dateFormatter.string(from: date as Date)
            }
        }
    }

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your friend's message and something else..."
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "zuckprofile")
        hasReadImageView.image = UIImage(named: "zuckprofile")
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0(68)]|", options: .init(), metrics: nil, views: ["v0": profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(68)]", options: .init(), metrics: nil, views: ["v0": profileImageView]))
        addConstraints([NSLayoutConstraint.init(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-86-[v0]|", options: .init(), metrics: nil, views: ["v0": dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: .init(), metrics: nil, views: ["v0": dividerLineView]))
    }
    
    private func setupContainerView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-90-[v0]|", options: .init(), metrics: nil, views: ["v0": containerView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]", options: .init(), metrics: nil, views: ["v0": containerView]))
        addConstraints([NSLayoutConstraint.init(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0][v1(80)]-12-|", options: .init(), metrics: nil, views: ["v0": nameLabel, "v1": timeLabel]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]-8-[v1(20)]-12-|", options: .init(), metrics: nil, views: ["v0": messageLabel, "v1": hasReadImageView]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(24)]|", options: .init(), metrics: nil, views: ["v0": nameLabel, "v1": messageLabel]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(24)]|", options: .init(), metrics: nil, views: ["v0": timeLabel]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(20)]|", options: .init(), metrics: nil, views: ["v0": hasReadImageView]))
        
    }
    
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .blue
    }
}
