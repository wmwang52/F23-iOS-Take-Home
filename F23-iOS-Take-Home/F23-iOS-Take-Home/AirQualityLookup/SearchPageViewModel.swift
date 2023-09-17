//
//  SearchPageViewModel.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import Foundation

@MainActor
class SearchPageViewModel: ObservableObject {
    @Published var state: LoadingState = .idle // Published property to track the loading state
    @Published var location = Location(latitude: 0.0, longitude: 0.0) // Published property to store location information
    @Published var AirQualityData = IQAir.sampleData // Published property to store IQAir data
    
    private let locationManager = LocationManager() // Instance of LocationManager for handling location updates
    private let service = IQAirService() // Instance of IQAirService for making API requests

    init() {
        locationManager.delegate = self // Initialize the LocationManager delegate
    }

    public func startAirQualitySearch() {
        state = .loading // Set the loading state to indicate the search has started
        locationManager.requestLocation() // Request the user's location
    }
}

extension SearchPageViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        Task { // Perform asynchronous task
            do {
                let AirQuality = try await service.search(latitude: location.latitude, longitude: location.longitude) // Fetch IQAir data based on user's location
                self.state = .success(AirQuality) // Set the loading state to success
                AirQualityData = AirQuality // Update the IQAir data property

            } catch {
                self.state = .error(error.localizedDescription) // Set the loading state to error and log the error description
            }
        }
    }

    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        state = .error(error.localizedDescription) // Set the loading state to error and log the error description
    }
}
