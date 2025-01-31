//
//  Transaction.swift
//  BudgetTracker
//
//  Created by admin on 27/01/25.
//

import SwiftUI
import CoreData

class Transaction: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchTransactions()
    }
    
    func fetchTransactions() {
        let request: NSFetchRequest<TransactionModel> = TransactionModel.fetchRequest()
        let result = try? viewContext.fetch(request)
        transactions = result ?? []
    }
    
    func addTransaction(_ title: String, amount: Double, type: String) {
        let newTransaction = TransactionModel(context: viewContext)
        newTransaction.id = UUID()
        newTransaction.title = title
        newTransaction.amount = amount
        newTransaction.type = type
        
        saveContext()
        fetchTransactions()
    }
    
    func updateTransaction(_ transaction: TransactionModel) {
        saveContext()
        fetchTransactions()
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        for index in offsets {
            let transaction = transactions[index]
            viewContext.delete(transaction)
        }
        saveContext()
        fetchTransactions()
    }
    
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
}
