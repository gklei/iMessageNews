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
		case .news: return "http://rss.nytimes.com/services/xml/rss/nyt/US.xml"
		case .sports: return "https://www.espn.com/espn/rss/news"
		case .politics: return "http://www.politico.com/rss/politicopicks.xml"
		case .business: return "http://rss.nytimes.com/services/xml/rss/nyt/Business.xml"
		case .humor: return "http://www.newyorker.com/feed/humor"
		}
	}
	
	var icon: UIImage {
		switch self {
		case .tech: return #imageLiteral(resourceName: "tech")
		case .sports: return #imageLiteral(resourceName: "sports")
		case .politics: return #imageLiteral(resourceName: "politics")
		case .business: return #imageLiteral(resourceName: "business")
		case .news: return #imageLiteral(resourceName: "news")
		case .humor: return #imageLiteral(resourceName: "humor")
		}
	}
}
