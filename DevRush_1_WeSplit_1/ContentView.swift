//
//  ContentView.swift
//  DevRush_1_WeSplit_1
//
//  Created by Sergey on 09.07.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 20
    let tipPercentages: [Int] = [0, 5, 10, 15, 20]
    let pikerText = String.LocalizationValue(stringLiteral: "people")
    let pikerText_ru_multiple = String.LocalizationValue(stringLiteral: "peoples")
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker(LocalizedStringKey("numberOfPeople"), selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            if $0 < 5 {
                                Text("\($0) \(String(localized: pikerText_ru_multiple))")
                            } else {
                                Text("\($0) \(String(localized: pikerText))")
                            }
                        }
                    }
                        .pickerStyle(.navigationLink)
                }
                
                Section(LocalizedStringKey("tipLabel")) {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle(LocalizedStringKey("mainTitle"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
