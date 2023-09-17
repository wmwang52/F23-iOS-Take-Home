//
//  ContentView.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/14/23.
//

import SwiftUI

struct SearchPageView: View {
    @StateObject private var vm = SearchPageViewModel()
    @StateObject var vm2: FavoritesLookupViewModel

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        Button {
                            vm.startAirQualitySearch()
                        } label: {
                            Image("OhareAirImage")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 260)
                        }

                        Spacer()
                    }
                }

                Section("Results") {
                    switch vm.state {
                    case .success(let AirQuality):

                        Text("**Location:** \(AirQuality.data.city), \(AirQuality.data.state), \(AirQuality.data.country)")
                            .font(.title3)
                        Text("**MEP Standard AQI:** \(AirQuality.data.current.pollution.aqicn)")
                            .font(.title3)
                        Text("**EPA Standard AQI:**\(AirQuality.data.current.pollution.aqius)")
                            .font(.title3)
                        Text("**Humidity:** \(AirQuality.data.current.weather.hu)")
                            .font(.title3)
                        Text("**Temp in Celsius:** \(AirQuality.data.current.weather.tp)")
                            .font(.title3)

                    case .idle:
                        HStack {
                            Text("Currently Loading The Data!  ")
                            ProgressView()
                        }

                    case .loading:
                        HStack {
                            Text("Almost finished Loading The Data!  ")
                            ProgressView()
                        }

                    case .error:
                        Text("There was an Error with fetching the location")
                    }
                }
            }
            .navigationTitle("O'Hare Air")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        var listOfData = [vm.AirQualityData.data.city, vm.AirQualityData.data.state, vm.AirQualityData.data.country]
                        if !vm2.listOfCities.contains(listOfData) {
                            vm2.listOfCities.append(listOfData)
                            for city in vm2.listOfCities {
                                vm2.getDataFromState(CityInfo: city)
                            }
                            vm2.userDefaultsWrite()
                        }

                    } label: {
                        Text("Add To Favorites")
                    }
                }
            }
        }
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView(vm2: FavoritesLookupViewModel())
    }
}
