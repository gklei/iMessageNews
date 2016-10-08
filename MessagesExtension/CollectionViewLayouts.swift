//
//  CompactFeedsLayout.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/7/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import Messages

class RSSFeedsLayout: UICollectionViewFlowLayout {
	
	override init() {
		super.init()
		_commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		_commonInit()
	}
	
	convenience init(style: MSMessagesAppPresentationStyle) {
		switch style {
		case .compact:
			self.init(itemsPerColumn: 3, spacing: 10)
		case .expanded:
			self.init(itemsPerColumn: 2, spacing: 10)
		}
	}
	
	private convenience init(itemsPerColumn: Int, spacing: CGFloat) {
		self.init()
		_setupLayout(withItemsPerColumn: itemsPerColumn, itemSpacing: spacing)
	}
	
	private func _commonInit() {
		_setupLayout(withItemsPerColumn: 3, itemSpacing: 10)
	}
	
	private func _setupLayout(withItemsPerColumn itemsPerColumn: Int, itemSpacing: CGFloat) {
		let screenWidth: CGFloat = UIScreen.main.bounds.width
		let spacing: CGFloat = itemSpacing
		
		let totalSpacing: CGFloat = spacing * 2 + (spacing * (CGFloat(itemsPerColumn) - 1))
		let size = (screenWidth - totalSpacing) / CGFloat(itemsPerColumn)
		
		sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
		itemSize = CGSize(width: size, height: size)
		minimumLineSpacing = itemSpacing
	}
	
	static func compact() -> RSSFeedsLayout {
		return RSSFeedsLayout(itemsPerColumn: 3, spacing: 10)
	}
	
	static func expanded() -> RSSFeedsLayout {
		return RSSFeedsLayout(itemsPerColumn: 2, spacing: 10)
	}
}

class RSSFeedItemsLayout: UICollectionViewFlowLayout {
	override init() {
		super.init()
		_commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		_commonInit()
	}
	
	convenience init(style: MSMessagesAppPresentationStyle) {
		switch style {
		case .compact:
			self.init(itemsPerColumn: 1, spacing: 10, itemHeight: 60)
		case .expanded:
			self.init(itemsPerColumn: 1, spacing: 10, itemHeight: 80)
		}
	}
	
	private convenience init(itemsPerColumn: Int, spacing: CGFloat, itemHeight: CGFloat) {
		self.init()
		_setupLayout(withItemsPerColumn: itemsPerColumn,
		             itemSpacing: spacing,
		             itemHeight: itemHeight)
	}
	
	private func _commonInit() {
		_setupLayout(withItemsPerColumn: 1, itemSpacing: 10, itemHeight: 40)
	}
	
	private func _setupLayout(withItemsPerColumn itemsPerColumn: Int, itemSpacing: CGFloat, itemHeight: CGFloat) {
		let screenWidth: CGFloat = UIScreen.main.bounds.width
		let spacing: CGFloat = itemSpacing
		
		let totalSpacing: CGFloat = spacing * 2 + (spacing * (CGFloat(itemsPerColumn) - 1))
		let size = (screenWidth - totalSpacing) / CGFloat(itemsPerColumn)
		
		sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
		itemSize = CGSize(width: size, height: itemHeight)
	}
	
	static func compact() -> RSSFeedItemsLayout {
		return RSSFeedItemsLayout(itemsPerColumn: 1, spacing: 10, itemHeight: 60)
	}
	
	static func expanded() -> RSSFeedItemsLayout {
		return RSSFeedItemsLayout(itemsPerColumn: 1, spacing: 10, itemHeight: 80)
	}
}