//
//  TransactionsView.swift
//  BudgetTracker
//
//  Created by admin on 30/01/25.
//

import SwiftUI

struct TransactionsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Transaction.entity(),
        sortDescriptors: []
    ) private var transactions: FetchedResults<Transaction>
    
    @State private var showAddTransactionView = false
    @State private var editTransaction: Transaction?
    
    var totalIncome: Double { transactions.filter { $0.type == "Income" }.reduce(0) { $0 + $1.amount } }
    var totalExpense: Double { transactions.filter { $0.type == "Expense" }.reduce(0) { $0 + $1.amount } }
    var balance: Double { totalIncome - totalExpense }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 15) {
                    Text("Balance: $\(balance, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Total Income: $\(totalIncome, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.green)
                    
                    Text("Total Expense: $\(totalExpense, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                .padding(30)
                
                List {
                    ForEach(transactions) { transaction in
                        NavigationLink(destination: EditTransactionView(transaction: transaction)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.title ?? "No Title")
                                        .font(.system(size: 18, weight: .semibold))
                                        
                                    Text(transaction.type ?? "No Type")
                                        .font(.system(size: 17))
                                        .foregroundColor(transaction.type == "Income" ? .green : .red)
                                }
                                Spacer()
                                Text("\(transaction.amount, specifier: "%.2f")")
                                    .font(.headline)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteTransaction(transaction)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("All Transactions", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("All Transactions")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.vertical, 20)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddTransactionView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTransactionView) {
                AddTransactionView()
            }
        }
    }
    
    private func deleteTransaction(_ transaction: Transaction) {
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting transaction: \(error)")
        }
    }
    
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
