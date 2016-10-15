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

protocol RSSFeedItemCellDelegate: class {
	func readButtonTapped(forItem item: RSSItem)
}

class RSSFeedItemCell: UICollectionViewCell {
	
	@IBOutlet fileprivate var titleLabel: UILabel!
	@IBOutlet fileprivate var descriptionLabel: UILabel!
	@IBOutlet fileprivate var sourceLabel: UILabel!
	
	@IBOutlet fileprivate var thumbnailImageView: AsyncImageView!
	
	var info: RSSFeedInfo?
	var item: RSSItem?
	
	weak var delegate: RSSFeedItemCellDelegate?
	
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
	
	func configure(withInfo info: RSSFeedInfo, index: Int) {
		
		guard info.feed.items.count > index else {
			fatalError("Index \(index) out of bounds for feed items: \(info.feed.items)")
		}
		
		self.info = info
		sourceLabel.text = info.feed.title
		
		let item = info.feed.items[index]
		self.item = item
		_syncUI(withItem: item)
	}
	
	private func _syncUI(withItem item: RSSItem) {
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
				self.thumbnailImageView.image = self.info?.type.icon
			}
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		thumbnailImageView.image = info?.type.icon
	}
	
	@IBAction fileprivate func _readButtonPressed() {
		guard let item = item else { return }
		delegate?.readButtonTapped(forItem: item)
	}
}
