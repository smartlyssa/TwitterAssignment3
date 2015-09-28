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
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


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
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        
        get {
        
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                NSUserDefaults.standardUserDefaults().synchronize()
                if data != nil {
                    if let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as?NSDictionary {
                    _currentUser = User(dictionary: dictionary)
                    } else {
                        print("Error serializing JSON data")
                    }
                } else {
                    print("data is nil")
                }
            }
        
            return _currentUser
        }
        
        set(user) {
            
            _currentUser = user
            
            if _currentUser != nil {
                if let data = try! NSJSONSerialization.dataWithJSONObject((user?.dictionary)!, options: []) as?NSData {
                    
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)

                }
                    
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                
            }// if
            NSUserDefaults.standardUserDefaults().synchronize()
        }  // set
    } // currentUser

}
