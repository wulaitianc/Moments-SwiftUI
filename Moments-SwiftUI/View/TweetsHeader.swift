//
//  TweetsHeader.swift
//  Moments
//
//  Created by NAVER on 2020/11/1.
//  Copyright © 2020 naver. All rights reserved.
//

import SwiftUI
import FakeFisher

struct TweetsHeader: View {
    
    var userInfo: UserInfoModel
        
    var body: some View {

        FFImage(userInfo.profileImage,
                placeholder: AnyView(Image("placeholder")))
            .aspectRatio(contentMode: .fit)
            .clipped()
            .overlay(
                HStack{
                    Text(userInfo.username)
                        .foregroundColor(.white)
                        .font(.headline)
                    FFImage(userInfo.avatar,
                            placeholder: Common.placeholder)
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                }.offset(x: -15, y: 16),
                alignment: .bottomTrailing
            )
            
    }
}


struct TweetsHeader_Previews: PreviewProvider {
    

    static var previews: some View {
        
        TweetsHeader(userInfo: PreviewData.userInfo)
    }
}
