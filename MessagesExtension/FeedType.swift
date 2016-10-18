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
		case .sports: return "http://www.espn.com/espn/rss/news"
		case .politics: return "http://www.politico.com/rss/politicopicks.xml"
		case .business: return  "http://www.wsj.com/xml/rss/3_7014.xml"
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
	
	var color: UIColor? {
		switch self {
		case .tech: return UIColor(hexString: "43A6DD")
		case .sports: return UIColor(hexString: "FF9C7A")
		case .politics: return UIColor(hexString: "B3BBB8")
		case .business: return UIColor(hexString: "C3A6DD")
		case .news: return UIColor(hexString: "43DDBB")
		case .humor: return UIColor(hexString: "FFDE4D")
		}
	}
}
