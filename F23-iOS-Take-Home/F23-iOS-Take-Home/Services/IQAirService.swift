//
//  IQAirService.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import Foundation

// Define the API key to access IQAir data
var APIKEY = 

// Define a struct responsible for handling IQAir-related operations
struct IQAirService {
    private let session: URLSession = .shared // Initialize a shared URLSession for network requests
    private let decoder: JSONDecoder = .init() // Initialize a JSONDecoder for decoding JSON responses
}

extension IQAirService {
    // Define a function to search for IQAir data based on latitude and longitude
    public func search(latitude: Double, longitude: Double) async throws -> IQAir {
        // Construct the URL for the "nearest_city" API endpoint
        var components = URLComponents(string: "https://api.airvisual.com/v2/nearest_city")
        
        // Add query parameters for latitude, longitude, and the API key
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "key", value: "\(APIKEY)")
        ]
        
        // Ensure that the URL is valid; otherwise, trigger a fatal error
        guard let url = components?.url else { fatalError("Invalid URL") }
        
        // Perform an asynchronous network request to fetch data from the URL
        let (data, _) = try await session.data(from: url)
        
        // Decode the received JSON data into an IQAir object
        let AirData = try decoder.decode(IQAir.self, from: data)
        
        // Return the decoded IQAir data
        return AirData
    }
}

extension IQAirService {
    // Define a function to search for IQAir data based on city, state, and country
    public func searchFromCities(city: String, state: String, country: String) async throws -> IQAir {
        // Construct the URL for the "city" API endpoint
        var components = URLComponents(string: "https://api.airvisual.com/v2/city")
        
        // Add query parameters for city, state, country, and the API key
        components?.queryItems = [
            URLQueryItem(name: "city", value: "\(city)"),
            URLQueryItem(name: "state", value: "\(state)"),
            URLQueryItem(name: "country", value: "\(country)"),
            URLQueryItem(name: "key", value: "\(APIKEY)")
        ]
        
        // Ensure that the URL is valid; otherwise, trigger a fatal error
        guard let url = components?.url else { fatalError("Invalid URL") }
        
        // Perform an asynchronous network request to fetch data from the URL
        let (data, _) = try await session.data(from: url)
        
        // Decode the received JSON data into an IQAir object
        let AirData = try decoder.decode(IQAir.self, from: data)
        
        // Return the decoded IQAir data
        return AirData
    }
}
