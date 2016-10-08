//
//  RSSFeedCell.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/7/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import AlamofireRSSParser

class RSSFeedCell: UICollectionViewCell {
	
	@IBOutlet fileprivate var label: UILabel!
	
	static let reuseID = "RSSFeedCellIdentifier"
	
	static func register(collectionView cv: UICollectionView) {
		let nib = UINib(nibName: "RSSFeedCell", bundle: nil)
		let identifier = reuseID
		
		cv.register(nib, forCellWithReuseIdentifier: identifier)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		label.textColor = .white
		
		layer.cornerRadius = 6.0
	}
	
	func configure(withFeedType type: FeedType) {
		label.text = type.rawValue
		backgroundColor = type.color
	}
}
