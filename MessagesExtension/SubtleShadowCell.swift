//
//  SubtleShadowCell.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/12/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit

class SubtleShadowCell: UICollectionViewCell {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		layer.shadowOpacity = 0.05
		layer.shadowRadius = 3
		layer.shadowOffset = CGSize(width: 0, height: 3)
		
		clipsToBounds = false
		contentView.clipsToBounds = true
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.shadowPath = UIBezierPath(rect: bounds).cgPath
	}
}
