//
//  CircleImage.swift
//  PeopleMonapp
//
//  Created by Rigel Preston on 12/19/16.
//  Copyright © 2016 Rigel Preston. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {
    func setupView(size: CGFloat) {
        let height = size / 2.0
        let width = size / 2.0
        self.layer.cornerRadius = min(height,width)
        self.clipsToBounds = true
    }
}

