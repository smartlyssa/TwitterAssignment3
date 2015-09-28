//
//  User.swift
//  SimpleTweets
//
//  Created by Lyssa Laudencia on 9/25/15.
//  Copyright © 2015 thegeekgoddess.net. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileImageURL: String?
    var tagLine: String?
    var dictionary: NSDictionary

    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
        
    }
    
    class var currentUser: User? {
        
        get {
        
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
        
                }
            }
        
            return _currentUser
        }
        
        set(user) {
            
            _currentUser = user
            
            if _currentUser != nil {
                if let data = try! NSJSONSerialization.dataWithJSONObject((user?.dictionary)!, options: []) as?NSDictionary {
                    
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
//                    dispatch_async(dispatch_get_main_queue()) {
//                        // do stuff
//                    }
                }
                    
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                
            }// if
            NSUserDefaults.standardUserDefaults().synchronize()
        }  // set
    } // currentUser

}
