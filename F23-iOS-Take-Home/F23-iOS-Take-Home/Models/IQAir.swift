//
//  AirData.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import Foundation

struct IQAir: Codable, Identifiable {
    let id = UUID()
    let status: String
    let data: DataClass
}

struct DataClass: Codable {
    let city, state, country: String
    let location: LocationCords
    let current: Current
}

struct Current: Codable {
    let pollution: Pollution
    let weather: Weather
}

struct Pollution: Codable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}

struct Weather: Codable {
    let ts: String
    let tp, pr, hu: Int
    let ws: Double
    let wd: Int
    let ic: String
}

struct LocationCords: Codable {
    let type: String
    let coordinates: [Double]
}

extension IQAir {
    static var sampleData: IQAir { IQAir(status: "OK", data: DataClass(city: "New York", state: "New York", country: "USA", location: LocationCords(type: "Point", coordinates: [40.7128, -74.0060]), current: Current(pollution: Pollution(ts: "2023-09-15T12:00:00Z", aqius: 25, mainus: "Good", aqicn: 20, maincn: "Good"), weather: Weather(ts: "2023-09-15T12:00:00Z", tp: 72, pr: 1015, hu: 50, ws: 5.0, wd: 180, ic: "Clear")))) }
}
