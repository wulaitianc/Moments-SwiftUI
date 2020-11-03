//
//  TweetListView.swift
//  Moments-SwiftUI
//
//  Created by NAVER on 2020/11/1.
//

import SwiftUI
import Refresh

struct TweetListView: View {
    @ObservedObject var viewModel: TweetListViewModel
    @State var footerRefreshing = false
    @State var allLoaded = false
    
    var body: some View {
        NavigationView(content: {
            content
                .navigationTitle("Moments")
        }).onAppear(perform: viewModel.refresh)
    }
}

private extension TweetListView {
    var content: some View {
        if let model = viewModel.userInfo{
            return AnyView(listView(model: model))
        }else{
            return AnyView(loading)
        }

    }
    
    private func listView(model: UserInfoModel) -> some View{    
        ScrollView{
            Section(header: TweetsHeader(userInfo: model)){
                ForEach(viewModel.dataSource){item in
                    TweetRow(viewModel: item)
                }
                
                if viewModel.dataSource.count > 0{
                RefreshFooter(refreshing: $footerRefreshing) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.allLoaded = self.viewModel.loadMoreTweets()
                        self.footerRefreshing = false
                    }
                } label: {
                    if self.allLoaded{
                        Text("All tweets loaded!").padding()
                    }else{
                        ProgressView().padding()
                    }
                }
                .noMore(allLoaded)
                .preload(offset: 50)
            }
            }
        }
        .enableRefresh()
    }
    
    private var loading: some View{
        Text("Loading...")
            .font(.title)
            .foregroundColor(.gray)
    }
}

struct TweetListView_Previews: PreviewProvider {
    
    static var previews: some View {
        TweetListView(viewModel: TweetListViewModel())
    }
}
