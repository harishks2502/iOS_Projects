//
//  Transaction.swift
//  BudgetTracker
//
//  Created by admin on 27/01/25.
//

import Foundation

struct TransactionModel: Identifiable {
    let id = UUID()
    var title: String
    var amount: Double
    var type: TransactionType
    
    enum TransactionType: String, CaseIterable, Identifiable {
        case income = "Income"
        case expense = "Expense"
        
        var id: String { rawValue }
    }
}

class Transaction: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    
    
    var balance: Double {
        let income = transactions.filter { $0.type == .income }.map { $0.amount }.reduce(0, +)
        let expenses = transactions.filter { $0.type == .expense }.map { $0.amount }.reduce(0, +)
        return income - expenses
    }
    
    var totalIncome: Double {
        transactions.filter{ $0.type == .income }.map { $0.amount }.reduce(0, +)
    }
    
    var totalExpenses: Double {
        transactions.filter{ $0.type == .expense }.map { $0.amount }.reduce(0, +)
    }
    
    func addTransaction(_ transaction: TransactionModel) {
        transactions.append(transaction)
    }
    
    func updateTransaction(_ transaction: TransactionModel, at index: Int){
        transactions[index] = transaction
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    
}
