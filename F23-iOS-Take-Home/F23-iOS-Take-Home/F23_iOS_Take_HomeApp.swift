//
//  F23_iOS_Take_HomeApp.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/14/23.
//

import SwiftUI

@main
struct F23_iOS_Take_HomeApp: App {
    @StateObject private var vm2 = FavoritesLookupViewModel()
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchPageView(vm2: vm2)
                    .tabItem {
                        Label("Current AQI", systemImage: "location.fill")
                    }

                FavoritesLookupView(vm: vm2)
                    .tabItem {
                        Label("Fvaorites", systemImage: "star.fill")
                    }
            }
            .task {
                do {
                    vm2.userDefaultsGet()

                    for city in vm2.listOfCities {
                        vm2.getDataFromState(CityInfo: city)
                    }
                    print(vm2.listOfCities)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
