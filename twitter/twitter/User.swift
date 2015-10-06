//
//  User.swift
//  twitter
//
//  Created by Jay Shah on 9/26/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageURL: String?
    var bannerImageURL: String?
    var tagline: String?
    var dictionary: NSDictionary
    var follwersCount: Int?
    var tweetsCount: Int?
    var followingCount: Int?
    
    init (dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        bannerImageURL = dictionary["profile_banner_url"] as? String
        tagline = dictionary["tagline"] as? String
        follwersCount = dictionary["followers_count"] as? Int
        tweetsCount = dictionary["statuses_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
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
                if data != nil {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                    _currentUser = User(dictionary: dictionary!)
                }
            }
        
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                let data = try! NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: .PrettyPrinted)
                
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
    
}
