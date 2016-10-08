//
//  RSSFeedDownloadController.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/7/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import AlamofireRSSParser
import Alamofire

extension Notification.Name {
	static let rssFeedDownloaded = Notification.Name("RSSMessage.feedDownloadedNotificationName")
}

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

class RSSFeedDownloadController {
	
	static let shared = RSSFeedDownloadController()
	
	func refreshAll() {
		FeedType.all.forEach {
			refreshFeed(withType: $0)
		}
	}

	func refreshFeed(withType type: FeedType) {
		Alamofire.request(type.url).responseRSS() { (response) -> Void in
			
			if let feed: RSSFeed = response.result.value {
				let info = RSSFeedInfo(feed: feed, type: type)
				
				RSSFeedCache.shared.update(feedInfo: info)
				NotificationCenter.default.post(name: .rssFeedDownloaded, object: nil, userInfo: info.userInfo)
			}
		}
	}
}

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
