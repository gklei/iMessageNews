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
	public static let rssItemDownloaded = Notification.Name("RSSMessage.itemDownloadedNotificationName")
	public static let rssFeedDownloaded = Notification.Name("RSSMessage.feedDownloadedNotificationName")
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
				let info: [String : Any] = ["rssFeed" : feed]
				NotificationCenter.default.post(name: .rssFeedDownloaded, object: nil, userInfo: info)
			}
		}
	}
}
