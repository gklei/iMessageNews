//
//  RSSFeedItemsLayout.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/11/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import Messages

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
			self.init(itemsPerColumn: 1, spacing: 16, itemHeight: 120)
		case .expanded:
			self.init(itemsPerColumn: 1, spacing: 16, itemHeight: 120)
		}
	}
	
	private convenience init(itemsPerColumn: Int, spacing: CGFloat, itemHeight: CGFloat) {
		self.init()
		_setupLayout(withItemsPerColumn: itemsPerColumn,
		             itemSpacing: spacing,
		             itemHeight: itemHeight)
	}
	
	private func _commonInit() {
		headerReferenceSize = CGSize(width: 0, height: 40)
	}
	
	private func _setupLayout(withItemsPerColumn itemsPerColumn: Int, itemSpacing: CGFloat, itemHeight: CGFloat) {
		let screenWidth: CGFloat = UIScreen.main.bounds.width
		let spacing: CGFloat = itemSpacing
		
		let totalSpacing: CGFloat = spacing * 2 + (spacing * (CGFloat(itemsPerColumn) - 1))
		let size = (screenWidth - totalSpacing) / CGFloat(itemsPerColumn)
		
		sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
		minimumLineSpacing = 16
		itemSize = CGSize(width: size, height: itemHeight)
	}
	
	func size(forItemAtIndexPath ip: IndexPath) -> CGSize {
		if ip.row == 0 {
			return CGSize(width: itemSize.width, height: 40)
		} else {
			return itemSize
		}
	}
}
