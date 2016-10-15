//
//  MSMessage+RSS.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/12/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import Foundation
import Messages
import AlamofireRSSParser
import AsyncImageView

extension MSMessage {
	convenience init?(feedInfo: RSSFeedInfo, index: Int) {
		guard feedInfo.feed.items.count > index else { return nil }
		let item = feedInfo.feed.items[index]
		guard let link = item.link else { return nil }
		
		self.init()
		let url = URL(string: link)
		self.url = url
		
		let layout = MSMessageTemplateLayout()
		layout.imageTitle = item.title
		layout.imageSubtitle = item.content
		
		if let imageURL = item.imagesFromDescription?.first, let url = URL(string: imageURL) {
			let image = AsyncImageLoader.defaultCache().object(forKey: url as AnyObject) as? UIImage
			
			layout.image = image?.maskWithColor(color: UIColor(white: 0, alpha: 0.3))
		} else if let imageURL = item.mediaContent, let url = URL(string: imageURL) {
			let image = AsyncImageLoader.defaultCache().object(forKey: url as AnyObject) as? UIImage
			layout.image = image?.maskWithColor(color: UIColor(white: 0, alpha: 0.3))
		} else {
			layout.image = feedInfo.type.icon
		}
		
		layout.caption = feedInfo.feed.title
		layout.trailingCaption = "READ ➞"
		
		if let date = item.pubDate {
			let formatter = DateFormatter()
			formatter.dateStyle = .medium
			layout.imageSubtitle = formatter.string(from: date)
		}
		
		self.layout = layout
	}
}

extension UIImage {
	func maskWithColor(color: UIColor) -> UIImage? {
		
		let maskImage = self.cgImage
		let width = self.size.width
		let height = self.size.height
		let bounds = CGRect(x: 0, y: 0, width: width, height: height)
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
		let bitmapContext = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) //needs rawValue of bitmapInfo
		
		bitmapContext?.clip(to: bounds, mask: maskImage!)
		bitmapContext!.setFillColor(color.cgColor)
		bitmapContext!.fill(bounds)
		
		//is it nil?
		if let cImage = bitmapContext!.makeImage() {
			let coloredImage = UIImage(cgImage: cImage)
			return coloredImage
			
		} else {
			return nil
		}
	}
}
