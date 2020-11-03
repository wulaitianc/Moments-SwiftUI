//
//  UserInfoView.swift
//  Moments-SwiftUI
//
//  Created by NAVER on 2020/11/3.
//

import SwiftUI
import FakeFisher

struct UserInfoView: View {
    var userInfo: TweetModel.User
    
    var body: some View {
        VStack{
            FFImage(userInfo.avatar, placeholder: Common.placeholder)
                .aspectRatio(contentMode: .fit)
            Text(userInfo.username)
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(userInfo: PreviewData.tweets[0].sender!)
    }
}
