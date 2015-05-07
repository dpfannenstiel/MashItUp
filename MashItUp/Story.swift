//
//  Story.swift
//  MashItUp
//
//  Created by Dustin Pfannenstiel on 5/5/15.
//  Copyright (c) 2015 Dustin Pfannenstiel. All rights reserved.
//

import UIKit

class Story: NSObject {
	
	let identifier:String?
	let title:String?
	let author:String?
	let postDate:NSDate?
	let link:NSURL?
	let excerpt:String?
	let channel:String?
	
	init(dictionary:[String:AnyObject]) {
		
		identifier = dictionary["_id"] as! String?
		title = dictionary["title"] as! String?
		author = dictionary["author"] as! String?
		excerpt = dictionary["excerpt"] as! String?
		channel = dictionary["channel"] as! String?
		
		if let urlString = dictionary["link"] as? String {
			link = NSURL(string: urlString)
		} else {
			link = nil
		}
		
		postDate = NSDate()
		
		
	}
	
}
