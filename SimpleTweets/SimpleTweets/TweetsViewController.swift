//
//  TweetsViewController.swift
//  SimpleTweets
//
//  Created by Lyssa on 9/27/15.
//  Copyright © 2015 thegeekgoddess.net. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    let TWEET_LIMIT = 20
    
    @IBOutlet var tweetsTableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshTweets", forControlEvents: UIControlEvents.ValueChanged)
        
        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = tweetsTableView
        dummyTableVC.refreshControl = refreshControl
        
        // Do any additional setup after loading the view.
        refreshTweets()
        
    }

    @IBAction func onLogOut(sender: AnyObject) {
        
        User.currentUser?.logout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        let currentTweet = tweets![indexPath.row]
        
        cell.tweetTextLabel.text = currentTweet.text
        let url = NSURL(string: currentTweet.user!.profileImageURL!)
        cell.profilePicImageView.setImageWithURL(url)
        cell.nameLabel.text = currentTweet.user?.name
        cell.screenNameLabel.text = "@\(currentTweet.user!.screenName!)"
        
        let shortFormatter = NSDateFormatter()
        shortFormatter.dateFormat = "MM/dd/YYYY HH:mm"
        let newCreatedAt = shortFormatter.stringFromDate(currentTweet.createdAt!)
        cell.timeStampLabel.text = newCreatedAt
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        var tweetCount = tweets?.count ?? 0
//        
//        if tweetCount > TWEET_LIMIT {
//            tweetCount = TWEET_LIMIT
//        }
//        
//        return tweetCount
        print(tweets?.count)
        return tweets?.count ?? 0
    }
    
    func refreshTweets() {
        
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil) { (tweets, error) -> () in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tweets = tweets
                // print("TWEET COUNT: \(tweets?.count)")
                self.tweetsTableView.reloadData()
                self.refreshControl.endRefreshing()
                print("timeline refreshed")
            })
        }
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
