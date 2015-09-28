//
//  TweetCell.swift
//  SimpleTweets
//
//  Created by Lyssa Laudencia on 9/28/15.
//  Copyright © 2015 thegeekgoddess.net. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet var tweetTextLabel: UILabel!
    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var screenNameLabel: UILabel!
    @IBOutlet var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
