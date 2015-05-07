//
//  ArticleViewController.swift
//  MashItUp
//
//  Created by Dustin Pfannenstiel on 4/30/15.
//  Copyright (c) 2015 Dustin Pfannenstiel. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

	var link:NSURL?
	@IBOutlet weak var webView: UIWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if let url = link {
			webView.loadRequest(NSURLRequest(URL: url))
		}
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
