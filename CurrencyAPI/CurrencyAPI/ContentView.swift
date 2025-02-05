//
//  ContentView.swift
//  CurrencyAPI
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var apiService = CurrencyAPIService()

    var body: some View {
        NavigationView {
            List(apiService.currencyRates) { currency in
                HStack {
                    Text("1 INR =")
                        .font(.headline)
                    Spacer()
                    Text("\(currency.rate, specifier: "%.2f") \(currency.currency)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("INR Exchange Rates")
            .onAppear {
                apiService.fetchExchangeRates()
            }
        }
    }
}
