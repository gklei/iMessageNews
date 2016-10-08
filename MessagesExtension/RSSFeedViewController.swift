//
//  RSSFeedViewController.swift
//  RSSMessage
//
//  Created by Gregory Klein on 10/7/16.
//  Copyright © 2016 Incipia. All rights reserved.
//

import UIKit

class RSSFeedViewController: UIViewController {
	
	static func create() -> RSSFeedViewController {
		let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "RSSFeedViewController")
		return vc as! RSSFeedViewController
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func dismissButtonPressed() {
		dismiss(animated: true, completion: nil)
	}
}
