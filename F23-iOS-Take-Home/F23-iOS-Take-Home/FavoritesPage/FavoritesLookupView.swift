//
//  FavoritesLookupView.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/15/23.
//

import SwiftUI

struct FavoritesLookupView: View {
    @StateObject var vm: FavoritesLookupViewModel
    var body: some View {
        NavigationStack {
            List {
                Section("Favorites") {
                    ForEach(vm.listOfPlaces) { place in
                        NavigationLink {
                            CityDataView(AirQuality: place)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("**Location:** \(place.data.city), \(place.data.state), \(place.data.country)")
                                    .font(.callout)
                                Text("**EPA Standard AQI:**\(place.data.current.pollution.aqius)")
                                    .font(.callout)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct FavoritesLookupView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesLookupView(vm: FavoritesLookupViewModel())
    }
}
