//
//  HeadlineTableViewController.swift
//  MashItUp
//
//  Created by Dustin Pfannenstiel on 4/30/15.
//  Copyright (c) 2015 Dustin Pfannenstiel. All rights reserved.
//

import UIKit

class HeadlineTableViewController: UITableViewController {

	var keys:[String]?
	var articles:[String:AnyObject]?
	var dataSource:ArticlesDataProvider?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		NSNotificationCenter.defaultCenter().addObserver(self, selector: "articlesLoaded:", name: ArticlesDataProvider.DataProviderDidReloadNotification, object: nil)
		let adp = ArticlesDataProvider()
		tableView.delegate = adp
		tableView.dataSource = adp
		tableView.estimatedRowHeight = 90
		tableView.rowHeight = UITableViewAutomaticDimension
		adp.loadData()
		self.dataSource = adp
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func articlesLoaded(notification:NSNotification) {
		tableView.reloadData()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

		if segue.identifier == "loadWebView" {
			
			if let destination = segue.destinationViewController as? ArticleViewController {
				
				if let cell = sender as? ArticleCell {
			
					if let indexPath = tableView.indexPathForCell(cell) {
					
						if let story = dataSource?.stories?[indexPath.row] {
					
							// well, that was a lot of if let statement...
							
							destination.link = story.link
							destination.title = story.title
							
						
						}
						
					}
					
				}
				
			}
			
		}
		
	}
	

}

extension ArticlesDataProvider: UITableViewDelegate, UITableViewDataSource {
	
    // MARK: - Table view data source

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {

		var count = stories != nil ? 1 : 0
		
		return count

	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return stories?.count ?? 0

	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! ArticleCell

		let story = stories![indexPath.row]
		
		cell.headlineLabel.text = story.title
		
		if let author = story.author {
			cell.bylineLabel.text = "By " + author
		} else {
			cell.bylineLabel.text = ""
		}

		if let excerpt = story.excerpt {
			cell.body.text = excerpt
		} else {
			cell.body.text = ""
		}
		
        return cell
    }

}

class ArticleCell: UITableViewCell {
	@IBOutlet weak var headlineLabel: UILabel!
	@IBOutlet weak var bylineLabel: UILabel!
	@IBOutlet weak var body: UILabel!
	
}
