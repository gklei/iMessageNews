//
//  RSSFeedItemCell.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/8/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import AlamofireRSSParser
import AsyncImageView

class RSSFeedItemCell: UICollectionViewCell, FeedInfoConfigurable {
	
	@IBOutlet fileprivate var titleLabel: UILabel!
	@IBOutlet fileprivate var descriptionLabel: UILabel!
	@IBOutlet fileprivate var thumbnailImageView: AsyncImageView!
	
	static let reuseID = "RSSFeedItemCellIdentifier"
	
	static func register(collectionView cv: UICollectionView) {
		let nib = UINib(nibName: "RSSFeedItemCell", bundle: nil)
		let identifier = reuseID
		
		cv.register(nib, forCellWithReuseIdentifier: identifier)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 6.0
		titleLabel.textColor = .white
		descriptionLabel.textColor = .white
	}
	
	func configure(withFeedInfo info: RSSFeedInfo) {
		backgroundColor = info.type.color
	}
	
	func configure(withFeedItem item: RSSItem) {
		titleLabel.text = item.title
		descriptionLabel.text = item.link
		
		if let imageURL = item.imagesFromDescription?.first {
			print(imageURL)
			thumbnailImageView.imageURL = URL(string: imageURL)
		} else {
			thumbnailImageView.image = nil
		}
	}
}
