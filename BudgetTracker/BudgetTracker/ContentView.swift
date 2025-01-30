//
//  ContentView.swift
//  BudgetTracker
//
//  Created by admin on 27/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = Transaction()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 30) {
                BalanceSummaryView(
                    balance: viewModel.balance,
                    income: viewModel.totalIncome,
                    expenses: viewModel.totalExpenses
                )
                
                NavigationLink("View Transactions", destination: TransactionListView(viewModel: viewModel))
                    .padding()
                
                NavigationLink("Add Transaction", destination: TransactionFormView(viewModel: viewModel))
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Dashboard")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
