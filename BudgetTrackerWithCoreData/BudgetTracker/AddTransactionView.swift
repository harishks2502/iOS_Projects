//
//  AddTransactionView.swift
//  BudgetTracker
//
//  Created by admin on 30/01/25.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
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
                    TextField("Enter Title", text: $title)
                        .font(.system(size: 18))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Amount", text: $amount)
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
            .navigationBarTitle("Add New Transaction", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add New Transaction")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    addTransaction()
                    dismiss()
                }
                .disabled(amount.isEmpty || title.isEmpty)
                .font(.system(size: 18))
            )
        }
    }
    
    private func addTransaction() {
        let newTransaction = Transaction(context: viewContext)
        
        newTransaction.id = UUID()
        newTransaction.amount = Double(amount) ?? 0.0
        newTransaction.title = title
        newTransaction.type = type
    
        do {
            try viewContext.save()
        } catch {
            print("Error saving transaction: \(error)")
        }
        
    }
    
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
