//
//  Location.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import Foundation

struct Location {
    var latitude: Double
    var longitude: Double
}

extension Location: CustomStringConvertible {
    var description: String {
        return "latitude: \(latitude), Longitude: \(longitude)"
    }
}
