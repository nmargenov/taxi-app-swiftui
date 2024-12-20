//
//  SettingsView.swift
//  map-uper-test
//
//  Created by Nikolai Margenov on 2.11.24.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(K.Keys.kmKey) private var priceKm = K.DefaultValue.pricePerKm
    @AppStorage(K.Keys.minuteKey) private var priceMinute = K.DefaultValue.pricePerMin
    @AppStorage(K.Keys.languageKey) private var language = K.DefaultValue.language
    @AppStorage(K.Keys.currencyKey) private var currency = K.DefaultValue.currency

    
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
                    Spacer().containerRelativeFrame([.vertical])
                    VStack {
                        SettingsCard(title: "pricePerKm".translated(to: language), selection: $priceKm, maxValue: 201)
                        SettingsCard(title: "pricePerMin".translated(to: language), selection: $priceMinute, maxValue: 51)
                        SettingsCardStrings(title: "language".translated(to: language), selection: $language, array: K.Arrays.languagesArray)
                        SettingsCardStrings(title: "currency".translated(to: language), selection: $currency, array: K.Arrays.currenciesArray)
                    }
                    
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue.opacity(0.2))           .navigationTitle("settings".translated(to: language))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss view on back button tap
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            )
        }.navigationBarBackButtonHidden()
            .scrollBounceBehavior(.basedOnSize)
    }
}

struct SettingsCard: View {
    var title: String
    @Binding var selection: Double
    var maxValue: Int

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 5)
                    .foregroundStyle(Color(.white))
                Spacer()

                Picker("Select price", selection: $selection) {
                    ForEach(1..<maxValue, id: \.self) { index in
                        let value = Double(index) / 10.0
                        Text(String(format: "%.2f", value))
                            .tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 90)
                .padding()
                .background(Color(.lightGray))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
            .shadow(radius: 10)
            
        }
    }
}

struct SettingsCardStrings: View {
    var title: String
    @Binding var selection: String
    var array: [String]

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 5)
                    .foregroundStyle(Color(.white))
                Spacer()

                Picker("Select language", selection: $selection) {
                    ForEach(0..<array.count, id: \.self) { index in
                        let value = array[index]
                        Text(value).tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 90)
                .padding()
                .background(Color(.lightGray))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
            .shadow(radius: 10)
            
        }
    }
}


#Preview {
    SettingsView()
}
