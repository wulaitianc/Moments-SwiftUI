//
//  TweetListViewModel.swift
//  Moments-SwiftUI
//
//  Created by NAVER on 2020/11/1.
//

import Combine
import Foundation

class TweetListViewModel: ObservableObject {
    @Published var userInfo: UserInfoModel? = nil
    @Published var dataSource: [TweetModel] = []
    
    private var disposables = Set<AnyCancellable>()
    private let tweetsFetcher = TweetFetcher()
    private var allTweets: [TweetModel] = []
    private var tweetsLoaded = 0
    private let tweetsToLoad = 5

    func refresh() {
        doLogin()
        getTweets()        
    }
    
    /// Load next 5 tweets
    /// - Returns: whether all tweets are loaded
    @discardableResult
    func loadMoreTweets() -> Bool{
        if tweetsLoaded < allTweets.count {
            let index = min(tweetsLoaded + tweetsToLoad, allTweets.count)
            dataSource.append(contentsOf: allTweets[tweetsLoaded ..< index])
            tweetsLoaded = index
            return false
        }
        return true
    }
}

//MARK: Private Methods
private extension TweetListViewModel{
    func parseTweets(tweets: [TweetModel]) -> [TweetModel] {
        tweets.filter{$0.sender != nil && ($0.content != nil || $0.images != nil)}
    }
    
    func doLogin(){
        tweetsFetcher
            .doLogin()
            .sink {[weak self] (completion) in
                guard let self = self else{return}
                switch completion{
                case .failure(let error):
                    self.userInfo = nil
                    print(error)
                case .finished: break
                    
                }
            } receiveValue: {[weak self] (model) in
                guard let self = self else{return}
                self.userInfo = model
            }
            .store(in: &disposables)

    }
    
    func getTweets() {
        tweetsFetcher
            .getTweets()
            .sink { [weak self] (completion) in
                guard let self = self else {return}
                switch completion{
                case .failure(let error):
                self.allTweets = []
                self.dataSource = []
                print(error)
                case .finished:
                    self.loadMoreTweets()
                }
            } receiveValue: {[weak self] (list) in
                guard let self = self else {return}
                let parsedList = self.parseTweets(tweets: list)
                self.allTweets = parsedList
            }
            .store(in: &disposables)

    }

}
