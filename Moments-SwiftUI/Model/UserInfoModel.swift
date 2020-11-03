//
//  UserInfoModel.swift
//  Moments
//
//  Created by NAVER on 2019/9/26.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation

struct UserInfoModel: Codable {
    let profileImage: String
    let avatar: String
    let nick: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile-image"
        case avatar
        case nick
        case username
    }
    
}
