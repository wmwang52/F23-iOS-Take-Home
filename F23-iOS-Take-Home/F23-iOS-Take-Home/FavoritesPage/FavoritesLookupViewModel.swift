//
//  FavoritesLookupViewModel.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/16/23.
//

import Foundation

@MainActor
class FavoritesLookupViewModel: ObservableObject {
    @Published var listOfCities: [[String]] = [] // Array to store city information as an array of strings
    @Published var listOfPlaces: [IQAir] = [] // Array to store IQAir data objects

    var service = IQAirService() // Instance of the IQAirService for API requests
    let userDefaults = UserDefaults.standard // UserDefaults for data persistence
    

    public func userDefaultsWrite() {
        userDefaults.setValue(listOfCities, forKey: "cities") // Write the listOfCities to UserDefaults
    }

    public func userDefaultsGet() {
        if userDefaults.object(forKey: "cities") != nil {
            listOfCities = userDefaults.object(forKey: "cities") as! [[String]] // Retrieve and populate listOfCities from UserDefaults
        }
    }

    public func getDataFromState(CityInfo: [String]) {
        Task { // Perform asynchronous task
            do {
                let AirQuality = try await service.searchFromCities(city: "\(CityInfo[0])", state: "\(CityInfo[1])", country: "\(CityInfo[2])") // Fetch IQAir data for a specific city, state, and country
                listOfPlaces.append(AirQuality) // Append the fetched IQAir data to the listOfPlaces array

            } catch {
                print(error.localizedDescription) // Print any errors encountered during the data fetch
            }
        }
    }
}
