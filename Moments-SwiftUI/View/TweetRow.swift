//
//  SenderRow.swift
//  Moments
//
//  Created by NAVER on 2020/11/1.
//  Copyright © 2020 naver. All rights reserved.
//

import SwiftUI
import Combine
import FakeFisher

struct TweetRowConfig {
    static let avatarWidth: CGFloat = 50
    static let imagesInOneRow = 3
    static let multipleImageSpacing: CGFloat = 5
    
    static let columns: [GridItem] =
        Array(repeating: .init(.flexible(),
                               spacing: TweetRowConfig.multipleImageSpacing),
              count: TweetRowConfig.imagesInOneRow)
}

struct TweetRow: View {
    private let viewModel: TweetModel
    
    init(viewModel: TweetModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top){
            //avatar
            FFImage(viewModel.sender!.avatar,
                    placeholder: Common.placeholder)
                .frame(width: TweetRowConfig.avatarWidth,
                       height: TweetRowConfig.avatarWidth)
            VStack(alignment: .leading){
                
                //sender name
                if viewModel.sender != nil{
                    NavigationLink(
                        destination: UserInfoView(userInfo: viewModel.sender!),
                        label: {
                            Text(viewModel.sender!.username)
                        })
                }
                                
                //tweet text
                tweetContent(text: viewModel.content)

                //images
                imageRow(images: viewModel.images)

                //comments
                commentsView(comments: viewModel.comments)
            }
            Spacer()
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
    }
    
}

private extension TweetRow{
    func imageRow(images: [TweetModel.Image]?) -> some View {
        if let images = images, images.isEmpty == false {
            if images.count == 1 {
                return AnyView(singleImageRow(image: images.first!))
            }else{
                return AnyView(multipleImagesRow(images: images))
            }
        }else{
            return AnyView(EmptyView())
        }
    }
    
    func singleImageRow(image: TweetModel.Image) -> some View {
        HStack{
            Spacer()
            FFImage(image.url, placeholder: Common.placeholder)
                .aspectRatio(contentMode: .fit)
                .clipped()
            Spacer()
        }
    }
    
    func multipleImagesRow(images: [TweetModel.Image]) -> some View {
        LazyVGrid(columns: TweetRowConfig.columns) {
            ForEach(images) { (image) in
                FFImage(image.url, placeholder: Common.placeholder)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    func tweetContent(text: String?) -> some View {
        if let text = text {
            return AnyView(Text(text)
                            .fixedSize(horizontal: false, vertical: true))
        }else{
            return AnyView(EmptyView())
        }
    }
    
    func commentsView(comments: [TweetModel.Comment]?) -> some View {
        if let comments = comments {
            return AnyView(VStack(alignment: .leading){
                ForEach(comments) { item in
                    Text(item.sender.username)
                    .font(.subheadline)
                    .foregroundColor(Color.blue) +
                    Text(item.content)
                }
            })
        }else{
            return AnyView(EmptyView())
        }
    }
}

struct SenderRow_Previews: PreviewProvider {

    static var previews: some View {
        TweetRow(viewModel: PreviewData.tweets[0])
    }
}

