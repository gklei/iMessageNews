//
//  BackToTopicsHeader.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/11/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import SwiftHEXColors

class BackToTopicsCell: UICollectionViewCell {
	
	@IBOutlet fileprivate var _label: UILabel!
	
	static let reuseID = "BackToTopicsCellReuseID"
	
	static func register(collectionView cv: UICollectionView) {
		let nib = UINib(nibName: "BackToTopicsCell", bundle: nil)
		cv.register(nib, forCellWithReuseIdentifier: reuseID)
	}
	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? .white : UIColor(hexString: "E5E8EA")
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 4.0
		
		let attrs: [String : Any] = [
			NSForegroundColorAttributeName : UIColor(hexString: "858E98")!,
			NSFontAttributeName : UIFont.systemFont(ofSize: 12),
			NSKernAttributeName : 2.5
		]
		
		let attrString = NSAttributedString(string: "BACK TO TOPICS", attributes: attrs)
		_label.attributedText = attrString
	}
}
