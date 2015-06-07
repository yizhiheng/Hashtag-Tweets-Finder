//
//  User.swift
//  Twitter
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

// container to hold data about a Twitter user

public struct User: Printable
{
    public let screenName: String
    public let name: String
    public let profileImageURL: NSURL?
    public let verified: Bool
    public let id: String!
    
    public var description: String { var v = verified ? " ✅" : ""; return "@\(screenName) (\(name))\(v)" }

    // MARK: - Private Implementation

    init?(data: NSDictionary?) {
        let newName = data?.valueForKeyPath(TwitterKey.Name) as? String
        let newScreenName = data?.valueForKeyPath(TwitterKey.ScreenName) as? String
        if newName != nil && newScreenName != nil {
            name = newName!
            screenName = newScreenName!
            id = data?.valueForKeyPath(TwitterKey.ID) as? String
            if let newVerified = data?.valueForKeyPath(TwitterKey.Verified)?.boolValue {
                verified = newVerified
            } else {
                return nil
            }
            if let urlString = data?.valueForKeyPath(TwitterKey.ProfileImageURL) as? String {
                profileImageURL = NSURL(string: urlString)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    var asPropertyList: AnyObject {
        var dictionary = Dictionary<String,String>()
        dictionary[TwitterKey.Name] = self.name
        dictionary[TwitterKey.ScreenName] = self.screenName
        dictionary[TwitterKey.ID] = self.id
        dictionary[TwitterKey.Verified] = verified ? "YES" : "NO"
        dictionary[TwitterKey.ProfileImageURL] = profileImageURL?.absoluteString
        return dictionary
    }

    
    init() {
        screenName = "Unknown"
        name = "Unknown"
        verified = false
        profileImageURL = nil
        id = ""
    }
    
    struct TwitterKey {
        static let Name = "name"
        static let ScreenName = "screen_name"
        static let ID = "id_str"
        static let Verified = "verified"
        static let ProfileImageURL = "profile_image_url"
    }
}
