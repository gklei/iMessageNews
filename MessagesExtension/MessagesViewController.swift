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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		RSSFeedCell.register(collectionView: _collectionView)
		RSSFeedItemCell.register(collectionView: _collectionView)
		
		RSSFeedDownloadController.shared.refreshAll()
		
		let sel = #selector(MessagesViewController.feedDownloaded(_:))
		NotificationCenter.default.addObserver(self, selector: sel, name: .rssFeedDownloaded, object: nil)
	}
	
	internal func feedDownloaded(_ notification: Notification) {
		guard selectedFeed == nil else { return }
		
		guard let feedInfo = RSSFeedInfo(notification: notification) else { return }
		guard let index = FeedType.all.index(of: feedInfo.type) else { return }
		
		let ip = IndexPath(row: index, section: 0)
		guard let cell = _collectionView.cellForItem(at: ip) else { return }
		
		(cell as? FeedInfoConfigurable)?.configure(withFeedInfo: feedInfo)
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
			return info.feed.items.count
		} else {
			return FeedType.all.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let reuseID = selectedFeed != nil ? RSSFeedItemCell.reuseID : RSSFeedCell.reuseID
		return collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
	}
}

extension MessagesViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if selectedFeed == nil {
			let type = FeedType.all[indexPath.row]
			(cell as? RSSFeedCell)?.configure(withFeedType: type)
		} else {
			let item = selectedFeed!.feed.items[indexPath.row]
			(cell as? RSSFeedItemCell)?.configure(withFeedItem: item)
			(cell as? RSSFeedItemCell)?.configure(withFeedInfo: selectedFeed!)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if selectedFeed == nil {
			let type = FeedType.all[indexPath.row]
			if let feed = RSSFeedCache.shared.feed(forType: type) {
				selectedFeed = RSSFeedInfo(feed: feed, type: type)
			}
		} else {
			selectedFeed = nil
		}
		_collectionView.reloadData()
		_collectionView.setCollectionViewLayout(_currentCollectionViewLayout(), animated: true)
	}
}
