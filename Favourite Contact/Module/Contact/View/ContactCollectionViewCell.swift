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
        detailTextLabel?.numberOfLines = 0
        contentView.addSubview(detailTextLabel!)
        let heartImage = UIImage(named: "heart")
        favouriteButton = UIButton(frame: CGRect(x: frame.size.width - 40, y: 100, width: heartImage!.size.width / 2, height: heartImage!.size.height / 2))
        contentView.addSubview(favouriteButton!)
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: imageView!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 20)
        let leadingConstraint = NSLayoutConstraint(item: imageView!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 20)
        let widthConstraint = NSLayoutConstraint(item: imageView!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
        let heightConstraint = NSLayoutConstraint(item: imageView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
        contentView.addConstraints([topConstraint, leadingConstraint, widthConstraint, heightConstraint])
        
        favouriteButton?.translatesAutoresizingMaskIntoConstraints = false
        let buttontopConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 100)
        let buttonTrailingConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -20)
        let heartImage = UIImage(named: "heart")
        let buttonWidthConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: heartImage!.size.width / 2.0)
        let buttonHeightConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: heartImage!.size.height / 2)
        contentView.addConstraints([buttontopConstraint, buttonTrailingConstraint, buttonWidthConstraint, buttonHeightConstraint])
    }
}
