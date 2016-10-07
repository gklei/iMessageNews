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

struct FeedURL {
	static let tech = "https://www.wired.com/category/gear/feed/"
	static let news = "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"
	static let sports = "https://www.espn.com/espn/rss/news"
	static let funny = "https://www.dailyhaha.com/rss/pictures/"
}

class RSSFeedDownloadController: NSObject {

	func download() {
		
		Alamofire.request(FeedURL.sports).responseRSS() { (response) -> Void in
			if let feed: RSSFeed = response.result.value {
				for item in feed.items {
					print("SPORTS: \(item)")
				}
			}
		}
		
		Alamofire.request(FeedURL.tech).responseRSS { (response) in
			if let feed: RSSFeed = response.result.value {
				feed.items.forEach {
					print("TECH: \($0)")
				}
			}
		}
	}
}
