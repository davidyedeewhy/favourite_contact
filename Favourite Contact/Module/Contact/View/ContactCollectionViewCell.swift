//
//  ContactCollectionViewCell.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView?
    var textLabel: UILabel?
    var detailTextLabel: UILabel?
    var favouriteButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 200 / 255.0, green: 226 / 355.0, blue: 243 / 255.0, alpha: 1.0)
        imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
        imageView?.contentMode = .scaleAspectFit
        contentView.addSubview(imageView!)
        textLabel = UILabel(frame: CGRect(x: 20, y: 100, width: frame.size.width - 40, height: 20))
        contentView.addSubview(textLabel!)
        detailTextLabel = UILabel(frame: CGRect(x: 20, y: 120, width: frame.size.width - 40, height: 20))
        contentView.addSubview(detailTextLabel!)
        let heartImage = UIImage(named: "heart")
        favouriteButton = UIButton(frame: CGRect(x: frame.size.width - 40, y: 100, width: heartImage!.size.width / 2, height: heartImage!.size.height / 2))
        contentView.addSubview(favouriteButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
