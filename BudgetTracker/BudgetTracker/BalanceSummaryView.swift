//
//  BalanceSummaryView.swift
//  BudgetTracker
//
//  Created by admin on 28/01/25.
//

import SwiftUI

struct BalanceSummaryView: View {
    var balance: Double
    var income: Double
    var expenses: Double
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Current Balance: $\(balance, specifier: "%.2f")")
                .font(.title2)
            
            Text("Total Income: $\(income, specifier: "%.2f")")
                .foregroundColor(.green)
            
            Text("Total Expenses: $\(expenses, specifier: "%.2f")")
                .foregroundColor(.red)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
        .shadow(radius: 3)
    }
}


