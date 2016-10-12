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
	@IBOutlet fileprivate var sourceLabel: UILabel!
	
	@IBOutlet fileprivate var thumbnailImageView: AsyncImageView!
	
	var type: FeedType?
	
	static let reuseID = "RSSFeedItemCellIdentifier"
	
	static func register(collectionView cv: UICollectionView) {
		let nib = UINib(nibName: "RSSFeedItemCell", bundle: nil)
		let identifier = reuseID
		
		cv.register(nib, forCellWithReuseIdentifier: identifier)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 6.0
		backgroundColor = .white
		thumbnailImageView.crossfadeDuration = 0
		thumbnailImageView.layer.cornerRadius = 2.0
		thumbnailImageView.layer.masksToBounds = true
	}
	
	func configure(withFeedInfo info: RSSFeedInfo) {
		sourceLabel.text = info.feed.title
		type = info.type
	}
	
	func configure(withFeedItem item: RSSItem) {
		print(item)
		
		titleLabel.text = item.title
		
		if let author = item.author {
			descriptionLabel.text = author
		} else if let date = item.pubDate {
			let formatter = DateFormatter()
			formatter.dateStyle = .medium
			descriptionLabel.text = formatter.string(from: date)
		}
		
		if let imageURL = item.imagesFromDescription?.first {
			thumbnailImageView.imageURL = URL(string: imageURL)
		} else if let imageURL = item.mediaContent {
			thumbnailImageView.imageURL = URL(string: imageURL)
		}
		else {
			DispatchQueue.main.async {
				self.thumbnailImageView.image = self.type?.icon
			}
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		thumbnailImageView.image = type?.icon
	}
}
