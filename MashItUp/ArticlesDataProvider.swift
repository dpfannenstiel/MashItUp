//
//  ArticlesDataProvider.swift
//  MashItUp
//
//  Created by Dustin Pfannenstiel on 5/5/15.
//  Copyright (c) 2015 Dustin Pfannenstiel. All rights reserved.
//

import UIKit

class ArticlesDataProvider: NSObject {
	
	class var DataProviderDidReloadNotification:String { return "DataProviderDidReloadNotification" }
	
	let storiesEndpoint = NSURL(string: "http://www.mashable.com/stories.json")
	var stories:[Story]?
	
	
	func loadData() {
		
		let session = NSURLSession.sharedSession()
		
		if let url = self.storiesEndpoint {
			
			let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in

				
				var jsonError:NSError? = nil
				let object = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError) as! [String:AnyObject]
				
				self.createStories(object)
				
				
				
			})
			
			task.resume()
		}
		
	}
	
	func createStories(dictionary:[String:AnyObject]) {
		
		if let newStories = dictionary["new"] as? [[String:AnyObject]] {
			
			var storyObjects = [Story]()
			
			for storyDict in newStories {
				let storyObject = Story(dictionary: storyDict)
				storyObjects += [storyObject]
			}
			
			self.stories = storyObjects
						
		}
		
		self.postLoadNotification()
		
	}
	
	func postLoadNotification() {

		dispatch_async(dispatch_get_main_queue(), { () -> Void in
			NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: ArticlesDataProvider.DataProviderDidReloadNotification, object: nil))
		})
		
	}
	
}
