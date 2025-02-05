//
//  CurrencyAPIService.swift
//  CurrencyAPI
//
//  Created by admin on 04/02/25.
//

import Foundation

class CurrencyAPIService: ObservableObject {
    @Published var currencyRates: [CurrencyRate] = []

    func fetchExchangeRates() {
        guard let url = URL(string: "https://api.exchangerate-api.com/v4/latest/INR") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching currency data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                DispatchQueue.main.async {
                    self.currencyRates = decodedData.rates.map { CurrencyRate(currency: $0.key, rate: $0.value) }
                }
            } catch {
                print("Error decoding currency data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// API Response Model
struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
}

struct CurrencyRate: Codable, Identifiable {
    let id = UUID()
    let currency: String
    let rate: Double
}
