//
//  NetworkManager.swift
//  SeatsBooking
//
//  Created by NAVER on 2019/7/6.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation
import CombineMoya
import Moya
import Combine

let provider = MoyaProvider<MultiTarget>(callbackQueue: DispatchQueue.main)

class NetworkManager {
    static let shared = NetworkManager()
    
    public func sendRequest<T: Decodable>(_ target: TargetType) -> AnyPublisher<T, MoyaError>{
        provider
            .requestPublisher(MultiTarget(target))
            .map(T.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
