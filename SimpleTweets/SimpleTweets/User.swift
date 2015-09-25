//
//  User.swift
//  SimpleTweets
//
//  Created by Lyssa Laudencia on 9/25/15.
//  Copyright © 2015 thegeekgoddess.net. All rights reserved.
//

import UIKit

var _currentUser: User?

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
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
//                var data = NSJSONSerialization.dataWithJSONObject(obj: user!.dictionary, options: nil)            }
            
        }
        
    }

}
