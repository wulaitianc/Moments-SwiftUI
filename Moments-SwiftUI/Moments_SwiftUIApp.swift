//
//  Moments_SwiftUIApp.swift
//  Moments-SwiftUI
//
//  Created by NAVER on 2020/11/1.
//

import SwiftUI

@main
struct Moments_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TweetListView(viewModel: TweetListViewModel())
        }
    }
}
