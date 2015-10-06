//
//  ProfileViewController.swift
//  twitter
//
//  Created by Jay Shah on 10/5/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User!

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if user == nil {
            user = User.currentUser
        }
        
        self.profileImageView.setImageWithURL(NSURL(string: (user.profileImageURL!)))
        if user.bannerImageURL != nil {
            self.headerImageView.setImageWithURL(NSURL(string: (user.bannerImageURL!)))
        }
        
        self.nameLabel.text = user?.name!
        self.handleLabel.text = "@\((user?.screenname!)!)"
        
        self.tweetsCountLabel.text = "\((user?.tweetsCount!)!)"
        self.followingCountLabel.text = "\((user?.followingCount!)!)"
        self.followersCount.text =  "\((user?.follwersCount!)!)"
        
        
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
