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

class RSSFeedCell: UICollectionViewCell {
	
	@IBOutlet fileprivate var label: UILabel!
	@IBOutlet fileprivate var imageView: UIImageView!
	
	static let reuseID = "RSSFeedCellIdentifier"
	
	override var isHighlighted: Bool {
		didSet {
			if isHighlighted {
				UIView.animate(withDuration: 0.18, animations: { () -> Void in
					self.imageView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
				})
			}
			else {
				UIView.animate(withDuration: 0.2, animations: { () -> Void in
					self.imageView.transform = CGAffineTransform.identity
				})
			}
		}
	}
	
	static func register(collectionView cv: UICollectionView) {
		let nib = UINib(nibName: "RSSFeedCell", bundle: nil)
		let identifier = reuseID
		
		cv.register(nib, forCellWithReuseIdentifier: identifier)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		label.textColor = .black
		
		backgroundColor = .white
		layer.cornerRadius = 4.0
	}
	
	func configure(withFeedType type: FeedType) {
		label.text = type.rawValue.uppercased()
		imageView.image = type.icon
	}
}
