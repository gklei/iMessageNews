//
//  RSSCollectionViewHeader.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/11/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit

class RSSCollectionViewHeader: UICollectionReusableView {
	
	@IBOutlet fileprivate var _leftLabel: UILabel!
	@IBOutlet fileprivate var _rightLabel: UILabel!
	@IBOutlet fileprivate var _badgeContainerView: UIView!
	@IBOutlet fileprivate var _badgeLabel: UILabel!
	
	static let reuseID = "RSSCollectionViewHeaderReuseID"
	
	override func awakeFromNib() {
		super.awakeFromNib()
		_badgeContainerView.layer.cornerRadius = 4.0
	}
	
	func configure(withFeedInfo info: RSSFeedInfo?) {
		if let info = info {
			_badgeContainerView.isHidden = false
			_badgeLabel.text = "\(info.feed.items.count)"
			_rightLabel.text = "new stories"
			_leftLabel.text = info.type.rawValue.capitalized
		} else {
			_badgeContainerView.isHidden = true
			_leftLabel.text = "Feeds"
			_rightLabel.text = "Select a topic"
		}
	}
}
