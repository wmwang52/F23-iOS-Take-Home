//
//  FavoritesLookupViewModel.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/16/23.
//

import Foundation

@MainActor
class FavoritesLookupViewModel: ObservableObject {
    @Published var listOfCities:[[String]] = []
    @Published var listOfPlaces: [IQAir] = []

    var service = IQAirService()
    let userDefaults = UserDefaults.standard
    

    public func userDefaultsWrite() {
        userDefaults.setValue(listOfCities, forKey: "cities")
    }

    public func userDefaultsGet() {
        if userDefaults.object(forKey: "cities") != nil{
            listOfCities = userDefaults.object(forKey: "cities") as! [[String]]
        }
    }

    public func getDataFromState(CityInfo:[String]) {
        Task {
            do {
                let AirQuality = try await service.searchFromCities(city: "\(CityInfo[0])", state: "\(CityInfo[1])", country: "\(CityInfo[2])")
                listOfPlaces.append(AirQuality)

            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
