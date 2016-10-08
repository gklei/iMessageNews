//
//  RSSFeedCell.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/7/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import AlamofireRSSParser

protocol FeedInfoConfigurable {
	func configure(withFeedInfo info: RSSFeedInfo)
}

class RSSFeedCell: UICollectionViewCell, FeedInfoConfigurable {
	
	@IBOutlet fileprivate var label: UILabel!
	@IBOutlet fileprivate var totalItemsLabel: UILabel!
	
	static let reuseID = "RSSFeedCellIdentifier"
	
	static func register(collectionView cv: UICollectionView) {
		let nib = UINib(nibName: "RSSFeedCell", bundle: nil)
		let identifier = reuseID
		
		cv.register(nib, forCellWithReuseIdentifier: identifier)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		label.textColor = .white
		totalItemsLabel.textColor = .white
		layer.cornerRadius = 6.0
	}
	
	func configure(withFeedType type: FeedType) {
		label.text = type.rawValue
		backgroundColor = type.color
	}
	
	func configure(withFeedInfo info: RSSFeedInfo) {
		totalItemsLabel.text = "\(info.feed.items.count)"
		label.text = info.type.rawValue
		backgroundColor = info.type.color
	}
}
