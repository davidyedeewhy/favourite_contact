//
//  ContactCollectionReusableView.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import UIKit

class ContactCollectionReusableView: UICollectionReusableView {
    var button: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 50))
        button?.setTitle("Show more", for: .normal)
        button?.setTitleColor(.blue, for: .normal)
        self.addSubview(button!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
