//
//  CompactFeedsLayout.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/7/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit

class RSSFeedsCompactLayout: UICollectionViewFlowLayout {
	
	override init() {
		super.init()
		_commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		_commonInit()
	}
	
	private func _commonInit() {
		_setupLayout(withItemsPerColumn: 3, itemSpacing: 20)
	}
	
	private func _setupLayout(withItemsPerColumn itemsPerColumn: Int, itemSpacing: CGFloat) {
		let screenWidth: CGFloat = UIScreen.main.bounds.width
		let spacing: CGFloat = 20
		
		let totalSpacing: CGFloat = spacing * 2 + (spacing * (CGFloat(itemsPerColumn) - 1))
		let size = (screenWidth - totalSpacing) / CGFloat(itemsPerColumn)
		
		sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
		itemSize = CGSize(width: size, height: size)
	}
}

class RSSFeedsExpandedLayout: UICollectionViewFlowLayout {
	override init() {
		super.init()
		_commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		_commonInit()
	}
	
	private func _commonInit() {
		_setupLayout(withItemsPerColumn: 2, itemSpacing: 20)
	}
	
	private func _setupLayout(withItemsPerColumn itemsPerColumn: Int, itemSpacing: CGFloat) {
		let screenWidth: CGFloat = UIScreen.main.bounds.width
		let spacing: CGFloat = 20
		
		let totalSpacing: CGFloat = spacing * 2 + (spacing * (CGFloat(itemsPerColumn) - 1))
		let size = (screenWidth - totalSpacing) / CGFloat(itemsPerColumn)
		
		sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
		itemSize = CGSize(width: size, height: size)
	}
}
