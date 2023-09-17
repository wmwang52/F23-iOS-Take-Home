//
//  CityDataPage.swift
//  F23-iOS-Take-Home
//
//  Created by William Wang on 9/16/23.
//

import SwiftUI

struct CityDataView: View {
    var AirQuality: IQAir
    var body: some View {
        NavigationStack {
            List {
                Section("More data about the locaiton") {
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
                }
            }
        }
    }
}

struct CityDataPage_Previews: PreviewProvider {
    static var previews: some View {
        CityDataView(AirQuality: IQAir.sampleData)
    }
}
