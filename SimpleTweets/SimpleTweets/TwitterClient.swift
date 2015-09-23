//
//  TwitterClient.swift
//  SimpleTweets
//
//  Created by Lyssa Laudencia on 9/23/15.
//  Copyright © 2015 thegeekgoddess.net. All rights reserved.
//

import UIKit

let twitterConsumerKey = "3Ow6kE4Cghrfhoj8Iz5pXRlg1"
let twitterConsumerSecret = "qfGuhyX3X7oNLBj665RADM6ztKXKcYiXCLYXLye5Gwe93JhPOF"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    class var sharedInstance: TwitterClient {
        
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret )
        }
        
        return Static.instance
    }
    
}
