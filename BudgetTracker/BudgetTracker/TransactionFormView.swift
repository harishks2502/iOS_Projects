//
//  TransactionFormView.swift
//  BudgetTracker
//
//  Created by admin on 28/01/25.
//

import SwiftUI

struct TransactionFormView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: Transaction
    
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var type: TransactionModel.TransactionType = .expense
    
    var transaction: TransactionModel?
    var transactionIndex: Int?
    
    var body: some View {
        VStack{
            Form {
                Section(
                    header: Text("Transaction Details")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("Type", selection: $type) {
                        ForEach(TransactionModel.TransactionType.allCases) { transactionType in
                            Text(transactionType.rawValue)
                                .tag(transactionType)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Button(action: saveTransaction) {
                Text(transaction != nil ? "Update Transaction" : "Add Transaction")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.vertical, 8)
        }
        .onAppear{
            loadTransactionData()
        }
        .navigationTitle(transaction != nil ? "Edit Transaction" : "Add Transaction")
    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount) else{ return }
        
        let newTransaction = TransactionModel(title: title, amount: amountValue, type: type)
       
        if let index = transactionIndex {
            viewModel.updateTransaction(newTransaction, at: index)
        } else {
            viewModel.addTransaction(newTransaction)
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    private func loadTransactionData() {
        if let transaction = transaction {
            title = transaction.title
            amount = String(transaction.amount)
            type = transaction.type
        }
    }
    
}
