//
//  SettingsView.swift
//  map-uper-test
//
//  Created by Nikolai Margenov on 2.11.24.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("PricePerKm") private var priceKm = 2.4
    @AppStorage("PricePerMinute") private var priceMinute = 0.4
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    SettingsCard(title: "Price per km", selection: $priceKm, maxValue: 201)
                    SettingsCard(title: "Price per minute", selection: $priceMinute, maxValue: 51)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Make VStack take full screen size
            .background(Color.blue.opacity(0.1)) // Full screen background color
            .navigationTitle("Settings")
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
                .frame(width: 150)
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
