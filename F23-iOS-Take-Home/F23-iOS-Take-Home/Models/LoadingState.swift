//
//  LoadingState.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import Foundation

enum LoadingState {
    case idle
    case success(IQAir)
    case loading
    case error(String)
}
