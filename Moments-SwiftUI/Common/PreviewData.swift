//
//  PreviewData.swift
//  Moments-SwiftUI
//
//  Created by NAVER on 2020/11/3.
//

import Foundation

struct PreviewData {
    static private let userInfoString = try! String(contentsOfFile: Bundle.main.path(forResource: "userInfo", ofType: "txt")!)
    static private let tweetsString = try! String(contentsOfFile: Bundle.main.path(forResource: "tweets", ofType: "txt")!)
    
    static let userInfo = try! JSONDecoder().decode(UserInfoModel.self, from: userInfoString.data(using: .utf8)!)
    static let tweets = try! JSONDecoder().decode([TweetModel].self, from: tweetsString.data(using: .utf8)!)
}
