//
//  TweetFetcher.swift
//  Moments
//
//  Created by NAVER on 2020/11/1.
//  Copyright © 2020 naver. All rights reserved.
//

import Foundation
import Combine
import Moya

protocol TweetFetchable {
    func doLogin() -> AnyPublisher<UserInfoModel, MoyaError>
    func getTweets() -> AnyPublisher<[TweetModel], MoyaError>
}

struct TweetFetcher: TweetFetchable {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func doLogin() -> AnyPublisher<UserInfoModel, MoyaError> {
        return networkManager
                .sendRequest(TWAPI.login)
    }
    
    func getTweets() -> AnyPublisher<[TweetModel], MoyaError> {
        return networkManager
                .sendRequest(TWAPI.tweets)
    }
}
