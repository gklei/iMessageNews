//
//  FeedType.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/7/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import SwiftHEXColors

enum FeedType: String {
	case tech, news, sports, politics, business, humor
	static let all: [FeedType] = [.tech, .news, .sports, .politics, .business, .humor]
}

extension FeedType {
	var url: String {
		switch self {
		case .tech: return "https://www.wired.com/category/gear/feed/"
		case .news: return "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"
		case .sports: return "https://www.espn.com/espn/rss/news"
		case .politics: return "https://www.dailyhaha.com/rss/pictures/"
		case .business: return "https://www.dailyhaha.com/rss/pictures/"
		case .humor: return "https://www.dailyhaha.com/rss/pictures/"
		}
	}
	
	var color: UIColor? {
		switch self {
		case .tech: return UIColor(hexString: "de2153")
		case .news: return UIColor(hexString: "3dc286")
		case .sports: return UIColor(hexString: "19d1e6")
		case .politics: return UIColor(hexString: "a15e80")
		case .business: return UIColor(hexString: "f2960d")
		case .news: return UIColor(hexString: "52ad98")
		case .humor: return UIColor(hexString: "f3b0b4")
		}
	}
}
