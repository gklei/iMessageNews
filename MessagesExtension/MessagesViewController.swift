//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Gregory Klein on 10/6/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
	
	@IBOutlet fileprivate var _collectionView: UICollectionView!
	var selectedFeed: RSSFeedInfo?
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		RSSFeedDownloadController.shared.refreshAll()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		RSSFeedCell.register(collectionView: _collectionView)
		RSSFeedItemCell.register(collectionView: _collectionView)
		BackToTopicsCell.register(collectionView: _collectionView)
		
		_collectionView.collectionViewLayout = RSSFeedsLayout(style: .compact)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		let offset: CGFloat = topLayoutGuide.length + bottomLayoutGuide.length
		let size = view.bounds.size
		let height = size.height - offset
		
		let calculatedFrame = CGRect(x: 0, y: topLayoutGuide.length, width: size.width, height: height)
		_collectionView.frame = calculatedFrame
	}
	
	
	override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
		if selectedFeed != nil {
			let layout = RSSFeedItemsLayout(style: presentationStyle)
			_collectionView.setCollectionViewLayout(layout, animated: true)
		} else {
			let layout = RSSFeedsLayout(style: presentationStyle)
			_collectionView.setCollectionViewLayout(layout, animated: true)
		}
	}
	
	override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
		_collectionView.contentInset = UIEdgeInsets.zero
		_collectionView.contentOffset = CGPoint.zero
	}
	
	fileprivate func _currentCollectionViewLayout() -> UICollectionViewLayout {
		if selectedFeed != nil {
			return RSSFeedItemsLayout(style: presentationStyle)
		} else {
			return RSSFeedsLayout(style: presentationStyle)
		}
	}
}

extension MessagesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let info = selectedFeed {
			return info.feed.items.count + 1
		} else {
			return FeedType.all.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let reuseID = _reuseID(forIndexPath: indexPath)
		return collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView,
	                    viewForSupplementaryElementOfKind kind: String,
	                    at indexPath: IndexPath) -> UICollectionReusableView {
		
		let reuseID = RSSCollectionViewHeader.reuseID
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
		                                                             withReuseIdentifier: reuseID,
		                                                             for: indexPath)
		return header
	}
	
	private func _currentReuseID() -> String {
		return selectedFeed != nil ? RSSFeedItemCell.reuseID : RSSFeedCell.reuseID
	}
	
	private func _reuseID(forIndexPath ip: IndexPath) -> String {
		if selectedFeed != nil {
			return ip.row == 0 ? BackToTopicsCell.reuseID : RSSFeedItemCell.reuseID
		} else {
			return RSSFeedCell.reuseID
		}
	}
}

extension MessagesViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView,
	                    willDisplay cell: UICollectionViewCell,
	                    forItemAt indexPath: IndexPath) {
		
		if let selectedInfo = selectedFeed, indexPath.row != 0 {
			let item = selectedInfo.feed.items[indexPath.row - 1]
			(cell as? RSSFeedItemCell)?.configure(withFeedItem: item)
			(cell as? RSSFeedItemCell)?.configure(withFeedInfo: selectedInfo)
		} else {
			let type = FeedType.all[indexPath.row]
			(cell as? RSSFeedCell)?.configure(withFeedType: type)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView,
	                    willDisplaySupplementaryView view: UICollectionReusableView,
	                    forElementKind elementKind: String,
	                    at indexPath: IndexPath) {
		
		switch elementKind {
		case UICollectionElementKindSectionHeader:
			if let info = selectedFeed {
				(view as? RSSCollectionViewHeader)?.configure(withFeedInfo: info)
			} else {
				(view as? RSSCollectionViewHeader)?.reset()
			}
		default: break
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if selectedFeed == nil {
			let type = FeedType.all[indexPath.row]
			if let feed = RSSFeedCache.shared.feed(forType: type) {
				selectedFeed = RSSFeedInfo(feed: feed, type: type)
				
				_collectionView.reloadData()
				_collectionView.setCollectionViewLayout(_currentCollectionViewLayout(), animated: true)
			}
		} else if indexPath.row == 0 {
			selectedFeed = nil
			_collectionView.reloadData()
			_collectionView.setCollectionViewLayout(_currentCollectionViewLayout(), animated: true)
		}
	}
}

extension MessagesViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch collectionViewLayout {
		case let layout as RSSFeedItemsLayout:
			return layout.size(forItemAtIndexPath: indexPath)
		case let layout as RSSFeedsLayout:
			return layout.itemSize
		default:
			fatalError("Invalid layout: \(collectionViewLayout)")
		}
	}
}
