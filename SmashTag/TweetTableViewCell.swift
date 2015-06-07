//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by Zhiheng Yi on 2015-06-02.
//  Copyright (c) 2015 Zhiheng Yi. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextlabel: UILabel!
    
    func updateUI() {
        tweetTextlabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        //tweetCreatedLabel?.text = nil
        
        if let tweet = self.tweet {
            tweetTextlabel?.text = tweet.text
            if tweetTextlabel?.text != nil {
                for _ in tweet.media {
                    tweetTextlabel.text! += " 📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL){
                    //会阻塞主进程
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
        }
    }
}
