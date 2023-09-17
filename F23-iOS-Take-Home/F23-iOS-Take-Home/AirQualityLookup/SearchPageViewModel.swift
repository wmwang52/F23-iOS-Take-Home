//
//  SearchPageViewModel.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import Foundation

@MainActor
class SearchPageViewModel: ObservableObject {
    @Published var state: LoadingState = .idle
    @Published var location = Location(latitude: 0.0, longitude: 0.0)
    @Published var AirQualityData = IQAir.sampleData

    private let locationManager = LocationManager()
    private let service = IQAirService()

    init() {
        locationManager.delegate = self
    }

    public func startAirQualitySearch() {
        state = .loading
        locationManager.requestLocation()
    }
    
}

extension SearchPageViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        Task {
            do {
                let AirQuality = try await service.search(latitude: location.latitude, longitude: location.longitude)
                self.state = .success(AirQuality)
                AirQualityData = AirQuality

            } catch {
                self.state = .error(error.localizedDescription)
            }
        }
    }

    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        state = .error(error.localizedDescription)
    }
}
