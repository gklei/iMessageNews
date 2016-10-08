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
	
	fileprivate let _compactLayout = RSSFeedsCompactLayout()
	fileprivate let _expandedLayout = RSSFeedsExpandedLayout()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		RSSFeedCell.register(collectionView: _collectionView)
		RSSFeedDownloadController.shared.refreshFeed(withType: .humor)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Conversation Handling
	
	override func willBecomeActive(with conversation: MSConversation) {
		// Called when the extension is about to move from the inactive to active state.
		// This will happen when the extension is about to present UI.
		
		// Use this method to configure the extension and restore previously stored state.
	}
	
	override func didResignActive(with conversation: MSConversation) {
		// Called when the extension is about to move from the active to inactive state.
		// This will happen when the user dissmises the extension, changes to a different
		// conversation or quits Messages.
		
		// Use this method to release shared resources, save user data, invalidate timers,
		// and store enough state information to restore your extension to its current state
		// in case it is terminated later.
	}
	
	override func didReceive(_ message: MSMessage, conversation: MSConversation) {
		// Called when a message arrives that was generated by another instance of this
		// extension on a remote device.
		
		// Use this method to trigger UI updates in response to the message.
	}
	
	override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
		// Called when the user taps the send button.
	}
	
	override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
		// Called when the user deletes the message without sending it.
		// Use this to clean up state related to the deleted message.
	}
	
	override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
		switch presentationStyle {
		case .expanded:
			_collectionView.setCollectionViewLayout(_expandedLayout, animated: true)
		case .compact:
			_collectionView.setCollectionViewLayout(_compactLayout, animated: true)
		}
	}
	
	override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
		_collectionView.contentInset = UIEdgeInsets.zero
		_collectionView.contentOffset = CGPoint.zero
	}
}

extension MessagesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return FeedType.all.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSSFeedCell.reuseID,
		                                              for: indexPath) as! RSSFeedCell
		
		let type = FeedType.all[indexPath.row]
		cell.configure(withFeedType: type)
		
		return cell
	}
}

extension MessagesViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	}
}
