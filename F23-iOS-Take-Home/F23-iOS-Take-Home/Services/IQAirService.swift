//
//  IQAirService.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import Foundation

var APIKEY = ""

struct IQAirService {
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = .init()
}

extension IQAirService {
    public func search(latitude: Double, longitude: Double) async throws -> IQAir {
        var components = URLComponents(string: "https://api.airvisual.com/v2/nearest_city")

        components?.queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"), URLQueryItem(name: "lon", value: "\(longitude)"), URLQueryItem(name: "key", value: "\(APIKEY)")]

        guard let url = components?.url else { fatalError("Invalid URl") }

        let (data, _) = try await session.data(from: url)

        let AirData = try decoder.decode(IQAir.self, from: data)

        return AirData
    }
}

extension IQAirService {
    public func searchFromCities(city: String, state: String, country: String) async throws -> IQAir {
        var components = URLComponents(string: "https://api.airvisual.com/v2/city")

        components?.queryItems = [URLQueryItem(name: "city", value: "\(city)"), URLQueryItem(name: "state", value: "\(state)"), URLQueryItem(name: "country", value: "\(country)"), URLQueryItem(name: "key", value: "\(APIKEY)")]

        guard let url = components?.url else { fatalError("Invalid URl") }
        print(url)

        let (data, _) = try await session.data(from: url)

        let AirData = try decoder.decode(IQAir.self, from: data)

        return AirData
    }
}
