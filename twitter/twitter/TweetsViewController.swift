//
//  TweetsViewController.swift
//  twitter
//
//  Created by Jay Shah on 9/26/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var nIndex = Int()
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detailsSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        let tweet = self.tweets?[indexPath.row]
        
        cell.nameLabel.text = tweet!.user?.name
        cell.handleLabel.text = "@\((tweet!.user?.screenname!)!)"
        cell.tweetLabel.text = tweet!.text
        cell.timeLabel.text = tweet!.time
        cell.retweetedLabel.text = ""
        
        cell.profileImage.setImageWithURL(NSURL(string: (tweet!.user?.profileImageURL!)!))
        
        cell.profileImage.tag = indexPath.row;
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onProfileImageTap:")
        tapGestureRecognizer.numberOfTapsRequired = 1;
        
        cell.profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
    func onRefresh () {
        self.fetchHomlineTweets()
        self.refreshControl.endRefreshing()
    }
    
    func fetchHomlineTweets () {
        TwitterClient.sharedInstance.homeTimeLineWithParam(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.estimatedRowHeight = 100
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "onRefresh", forControlEvents: .ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
        
        self.fetchHomlineTweets()
        
        
    }

    func onProfileImageTap (tapGesture: UITapGestureRecognizer) {
        performSegueWithIdentifier("profileSegue", sender: tapGesture.view?.tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier != "detailsSegue"){

            let user = self.tweets![sender as! Int].user
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.user = user
            
        } else if (segue.identifier != "detailsSegue"){
            
        } else {
            print(sender)

            
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPathForCell(cell)
            
            let tweet = self.tweets![indexPath!.row]
            let detailsTweetViewController = segue.destinationViewController as! DetailsTweetViewController
            
            print(detailsTweetViewController)
            
            detailsTweetViewController.currentTweet = tweet

        }
        
        
        
    }


}
