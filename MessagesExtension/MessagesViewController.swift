//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Gregory Klein on 10/6/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit
import Messages
import AlamofireRSSParser

class MessagesViewController: MSMessagesAppViewController {
	
	@IBOutlet fileprivate var _collectionView: UICollectionView!
	var selectedFeedInfo: RSSFeedInfo?
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		RSSFeedDownloadController.shared.refreshAll()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		RSSFeedCell.register(collectionView: _collectionView)
		RSSFeedItemCell.register(collectionView: _collectionView)
		BackToTopicsCell.register(collectionView: _collectionView)
		
		_collectionView.collectionViewLayout = RSSFeedsLayout(style: presentationStyle)
	}
	
	override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
		if selectedFeedInfo != nil {
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
	
	override func didBecomeActive(with conversation: MSConversation) {
		_collectionView.setCollectionViewLayout(_currentCollectionViewLayout(), animated: true)
		guard let message = conversation.selectedMessage else { return }
		guard let url = message.url else { return }
		_open(url: url)
	}
	
	override func didSelect(_ message: MSMessage, conversation: MSConversation) {
		guard let url = message.url else { return }
		_open(url: url)
	}
	
	fileprivate func _currentCollectionViewLayout() -> UICollectionViewLayout {
		if selectedFeedInfo != nil {
			return RSSFeedItemsLayout(style: presentationStyle)
		} else {
			return RSSFeedsLayout(style: presentationStyle)
		}
	}
}

extension MessagesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let info = selectedFeedInfo {
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
		return selectedFeedInfo != nil ? RSSFeedItemCell.reuseID : RSSFeedCell.reuseID
	}
	
	private func _reuseID(forIndexPath ip: IndexPath) -> String {
		if selectedFeedInfo != nil {
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
		switch cell {
		case let cell as RSSFeedCell: _configure(cell, indexPath: indexPath)
		case let cell as RSSFeedItemCell: _configure(cell, indexPath: indexPath)
		default: break
		}
	}
	
	private func _configure(_ cell: RSSFeedCell, indexPath ip: IndexPath) {
		let type = FeedType.all[ip.row]
		cell.configure(withFeedType: type)
	}
	
	private func _configure(_ cell: RSSFeedItemCell, indexPath ip: IndexPath) {
		guard let info = selectedFeedInfo, ip.row != 0 else { return }
		
		cell.delegate = self
		cell.configure(withInfo: info, index: ip.row - 1)
	}
	
	func collectionView(_ collectionView: UICollectionView,
	                    willDisplaySupplementaryView view: UICollectionReusableView,
	                    forElementKind elementKind: String,
	                    at indexPath: IndexPath) {
		switch view {
		case let view as RSSCollectionViewHeader:
			view.configure(withFeedInfo: selectedFeedInfo)
		default: break
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let feedInfo = selectedFeedInfo {
			if indexPath.row == 0 {
				_goBackToAllRSSFeeds()
			} else {
				let index = indexPath.row - 1
				_constructAndSend(feedInfo: feedInfo, atIndex: index)
				requestPresentationStyle(.compact)
			}
		} else {
			_openRSSFeed(atIndexPath: indexPath)
		}
	}
	
	private func _openRSSFeed(atIndexPath indexPath: IndexPath) {
		let type = FeedType.all[indexPath.row]
		if let feed = RSSFeedCache.shared.feed(forType: type) {
			selectedFeedInfo = RSSFeedInfo(feed: feed, type: type)
			
			_collectionView.reloadData()
			_collectionView.setCollectionViewLayout(_currentCollectionViewLayout(), animated: true)
		}
	}
	
	private func _goBackToAllRSSFeeds() {
		selectedFeedInfo = nil
		_collectionView.reloadData()
		_collectionView.setCollectionViewLayout(_currentCollectionViewLayout(), animated: true)
	}
	
	private func _constructAndSend(feedInfo info: RSSFeedInfo, atIndex index: Int) {
		let item = info.feed.items[index]
		guard let link = item.link else { return }
		activeConversation?.insertText(link, completionHandler: nil)
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

extension MessagesViewController: RSSFeedItemCellDelegate {
	func readButtonTapped(forItem item: RSSItem) {
		guard let link = item.link else { return }
		guard let url = URL(string: link) else { return }
		_open(url: url)
	}
	
	fileprivate func _open(url: URL) {
		let context = NSExtensionContext()
		context.open(url, completionHandler: nil)
		
		var responder = self as UIResponder?
		while responder != nil {
			if responder?.responds(to: Selector("openURL:")) == true {
				responder?.perform(Selector("openURL:"), with: url)
			}
			responder = responder!.next
		}
	}
}
