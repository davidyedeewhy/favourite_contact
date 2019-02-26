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
        textLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 260, height: 20))
        contentView.addSubview(textLabel!)
        detailTextLabel = UILabel(frame: CGRect(x: 20, y: 120, width: 260, height: 20))
        detailTextLabel?.numberOfLines = 0
        contentView.addSubview(detailTextLabel!)
        let heartImage = UIImage(named: "heart")
        favouriteButton = UIButton(frame: CGRect(x: 260, y: 100, width: heartImage!.size.width / 2, height: heartImage!.size.height / 2))
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
        let topConstraint = NSLayoutConstraint(item: imageView!, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20)
        let leadingConstraint = NSLayoutConstraint(item: imageView!, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        let widthConstraint = NSLayoutConstraint(item: imageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        let heightConstraint = NSLayoutConstraint(item: imageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        contentView.addConstraints([topConstraint, leadingConstraint, widthConstraint, heightConstraint])

        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        let textLabelTopConstraint = NSLayoutConstraint(item: textLabel!, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 100)
        let textLabelLeadingConstraint = NSLayoutConstraint(item: textLabel!, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        let textLabelWidthConstraint = NSLayoutConstraint(item: textLabel!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 260)
        let textLabelHeightConstraint = NSLayoutConstraint(item: textLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        contentView.addConstraints([textLabelTopConstraint, textLabelLeadingConstraint, textLabelWidthConstraint, textLabelHeightConstraint])
        
        detailTextLabel?.translatesAutoresizingMaskIntoConstraints = false
        let detailTextLabelTopConstraint = NSLayoutConstraint(item: detailTextLabel!, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 120)
        let detailTextLabelLeadingConstraint = NSLayoutConstraint(item: detailTextLabel!, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        let detailTextLabelWidthConstraint = NSLayoutConstraint(item: detailTextLabel!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 260)
        let detailTextLabelHeightConstraint = NSLayoutConstraint(item: detailTextLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        contentView.addConstraints([detailTextLabelTopConstraint, detailTextLabelLeadingConstraint, detailTextLabelWidthConstraint, detailTextLabelHeightConstraint])
        
        favouriteButton?.translatesAutoresizingMaskIntoConstraints = false
        let buttontopConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 100)
        let buttonTrailingConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20)
        let heartImage = UIImage(named: "heart")
        let buttonWidthConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: heartImage!.size.width / 2.0)
        let buttonHeightConstraint = NSLayoutConstraint(item: favouriteButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: heartImage!.size.height / 2)
        contentView.addConstraints([buttontopConstraint, buttonTrailingConstraint, buttonWidthConstraint, buttonHeightConstraint])
    }
}
