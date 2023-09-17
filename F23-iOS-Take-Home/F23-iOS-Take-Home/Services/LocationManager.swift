//
//  LocationManager.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import CoreLocation
import Foundation

protocol LocationManagerDelegate: AnyObject {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location)
    func locationManager(_ manager: LocationManager, didFailError error: Error)
}

class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager {
    func requestLocation() {
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let clLocation = locations.last else { return }

        let location = Location(latitude: clLocation.coordinate.latitude, longitude: clLocation.coordinate.longitude)

        delegate?.locationManager(self, didUpdateLocation: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationManager(self, didFailError: error)
    }
}
