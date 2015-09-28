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
    
    @IBOutlet var tweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            // print("TWEET COUNT: \(tweets?.count)")
            self.tweetsTableView.reloadData()
        }
        
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
        return tweets?.count ?? 0
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
