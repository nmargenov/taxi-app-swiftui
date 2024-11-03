////
//  SettingsView.swift
//  map-uper-test
//
//  Created by Nikolai Margenov on 2.11.24.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("PricePerKm") private var priceKm = 2.4
    @AppStorage("PricePerMinute") private var priceMinute = 0.4
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    SettingsCard(title: "Price per km", selection: $priceKm, maxValue: 201)
                    SettingsCard(title: "Price per minute", selection: $priceMinute, maxValue: 51)
                }.padding()
                    .toolbarBackground(.visible, for: .navigationBar)
                    .navigationBarTitle("Settings")
                    .onChange(of: priceKm) { oldValue, newValue in
                        if newValue != oldValue {
                            UserDefaults.standard.set(priceKm, forKey: "PricePerKm")
                        }
                    }
                    .onChange(of: priceMinute) { oldValue, newValue in
                        if newValue != oldValue {
                            UserDefaults.standard.set(priceMinute, forKey: "PricePerMinute")
                        }
                    }
            }
        }
    }
}

#Preview {
    SettingsView()
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

                Spacer()

                Picker("Select price", selection: $selection) {
                    ForEach(1..<maxValue, id: \.self) { index in // 0.00 to 20.00
                        let value = Double(index) / 10.0
                        Text(String(format: "%.2f", value))
                            .tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 150)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    SettingsView()
}
