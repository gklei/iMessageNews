//
//  RSSFeedCache.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/11/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import Foundation
import AlamofireRSSParser

class RSSFeedCache: NSObject {
	static let shared = RSSFeedCache()
	
	private var _feedDictionary: [FeedType : RSSFeed] = [:]
	
	override init() {
		super.init()
	}
	
	func update(feedInfo info: RSSFeedInfo) {
		_feedDictionary[info.type] = info.feed
	}
	
	func feed(forType type: FeedType) -> RSSFeed? {
		return _feedDictionary[type]
	}
}
