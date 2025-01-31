//
//  EditTransactionView.swift
//  BudgetTracker
//
//  Created by admin on 30/01/25.
//

import SwiftUI

struct EditTransactionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var transaction: Transaction
    @State private var title = ""
    @State private var amount = ""
    @State private var type = "Income"
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Transaction Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Edit Title", text: $title)
                        .font(.system(size: 18))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Edit Amount", text: $amount)
                        .font(.system(size: 18))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("Type", selection: $type) {
                        Text("Income").tag("Income")
                        Text("Expense").tag("Expense")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(height: 30)
                }
                .padding(.vertical, 10)
            }
        }
        .navigationBarTitle("Edit Transaction", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit Transaction")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.top, 10)
                    .padding(.bottom, 5)
            }
        }
        .navigationBarItems(
            leading: Button("Cancel") {
                dismiss()
            },
            trailing: Button("Update") {
                transaction.title = title
                transaction.amount = Double(amount) ?? 0.0
                transaction.type = type
                saveContext()
                dismiss()
            }
            .disabled(amount.isEmpty || title.isEmpty)
            .font(.system(size: 18))
        )
        .onAppear {
            title = transaction.title ?? ""
            amount = String(format: "%.2f", transaction.amount)
            type = transaction.type ?? "Income"
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
}
