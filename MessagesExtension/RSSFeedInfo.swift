//
//  RSSFeedInfo.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/11/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import Foundation
import AlamofireRSSParser

struct RSSFeedInfo {
	static let feedKey = "rssFeed"
	static let typeKey = "type"
	
	let feed: RSSFeed
	let type: FeedType
	
	var userInfo: [String : Any] {
		return [RSSFeedInfo.feedKey : feed, RSSFeedInfo.typeKey : type]
	}
	
	init(feed: RSSFeed, type: FeedType) {
		self.feed = feed
		self.type = type
	}
	
	init?(userInfo: [AnyHashable : Any]) {
		guard let feed = userInfo[RSSFeedInfo.feedKey] as? RSSFeed,
			let type = userInfo[RSSFeedInfo.typeKey] as? FeedType else { return nil }
		
		self.feed = feed
		self.type = type
	}
	
	init?(notification: Notification) {
		guard let userInfo = notification.userInfo else { return nil }
		self.init(userInfo: userInfo)
	}
}
