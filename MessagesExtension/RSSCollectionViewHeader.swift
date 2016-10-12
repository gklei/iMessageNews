//
//  RSSCollectionViewHeader.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/11/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit

class RSSCollectionViewHeader: UICollectionReusableView, FeedInfoConfigurable {
	
	@IBOutlet fileprivate var _leftLabel: UILabel!
	@IBOutlet fileprivate var _rightLabel: UILabel!
	
	static let reuseID = "RSSCollectionViewHeaderReuseID"
	
	func configure(withFeedInfo info: RSSFeedInfo) {
		_rightLabel.text = "\(info.feed.items.count) new stories"
		_leftLabel.text = info.type.rawValue.capitalized
	}
	
	func reset() {
		_leftLabel.text = "Feeds"
		_rightLabel.text = "Select a topic"
	}
}
