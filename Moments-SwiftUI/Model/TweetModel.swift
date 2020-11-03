//
//  TweetModel.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/27.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation

struct TweetModel: Codable, Identifiable {
    let content: String?
    let images: [Image]?
    let sender: User?
    let comments: [Comment]?
    var id: String {
        (sender?.username ?? "sender") + (content ?? "content") + "\(UUID())"
    }
    
    struct Image: Codable, Identifiable {
    
        let id = UUID()
        let url: String
        
    }
    struct User: Codable {
        let username: String
        let nick: String
        let avatar: String
    }
    struct Comment: Codable, Identifiable {
        let content: String
        let sender: User
        
        var id: String{
            sender.username + content
        }
    }
}
