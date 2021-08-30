//
//  AddExpense.swift
//  Project_7_ iExpense
//
//  Created by Thomas George on 26/08/2021.
//

import SwiftUI

struct AddExpense: View {
    @Environment(\.presentationMode) var presentationMode
    
    // Ajout de la class Expenses partagee entre les vues
    @ObservedObject var expenses: Expenses
    
    @State private var name: String = ""
    @State private var type: String = "Personnal"
    @State private var amount: String = ""
    static let types = ["Business", "Personnal"]
    
    @State private var showingWrongAmountAlert: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarItems(trailing: Button("save"){
                if let actualAmount = Int(self.amount) {
                    // Creation d'une depense (structure)
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    // Ajout de la depenses dans la classe contenant la liste des depenses
                    self.expenses.items.append(item)
                    // Fermeture de la sheet
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingWrongAmountAlert = true
                }
            })
        }
        .alert(isPresented: $showingWrongAmountAlert) {
            Alert(title: Text("Error"), message: Text("Wrong amount type"), dismissButton: .cancel())
        }
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense(expenses: Expenses())
    }
}
