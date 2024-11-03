//
//  PreviewRideView.swift
//  map-uper-test
//
//  Created by Nikolai Margenov on 2.11.24.
//

import SwiftUI

struct PreviewRideView: View {
    @Environment(\.dismiss) var dismiss
    
    var traveledDistance: Double // Distance in meters
    let calculator = CalculatorManager()
    let seconds: Int // Time in seconds
    
    init(traveledDistance: Double, seconds: Int) {
        self.traveledDistance = traveledDistance
        self.seconds = seconds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.blue.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Swipe down handle
                    Rectangle()
                        .frame(width: 40, height: 5)
                        .foregroundColor(Color.gray.opacity(0.6))
                        .cornerRadius(2.5)
                        .padding(.top, 10)
                    
                    Text("Ride Summary")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Total distance card
                    SummaryCard(title: "Total Distance Traveled", value: String(format: "%.2f km", traveledDistance / 1000))
                    
                    // Price for distance card
                    SummaryCard(title: "Price for Distance Traveled", value: "$\(returnStringKmPrice())")
                    
                    // Seconds in use card formatted as minutes:seconds
                    SummaryCard(title: "Time in Use", value: formatTime(seconds))
                    
                    // Price for seconds card
                    SummaryCard(title: "Price for Time", value: "$\(returnStringTimePrice())")
                    
                    // Final total price card
                    SummaryCard(title: "Total Price", value: "$\(finalTotalPrice())")
                    
                    Spacer()
                    
                    // Close button
                    Button("Close") {
                        dismiss()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.headline)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func returnStringKmPrice() -> String {
        let price = calculator.calculateKmPrice(meters: traveledDistance)
        return String(format: "%.2f", price)
    }
    
    func returnStringTimePrice() -> String {
        let price = calculator.timePrice(time: seconds)
        return String(format: "%.2f", price)
    }
    
    func finalTotalPrice() -> String {
        let total = calculator.calculateKmPrice(meters: traveledDistance) + calculator.timePrice(time: seconds)
        return String(format: "%.2f", total)
    }
    
    // Function to format time in seconds to minutes:seconds
    func formatTime(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds) // Format: h:mm:ss
        } else {
            return String(format: "%d:%02d", minutes, seconds) // Format: mm:ss
        }
    }
}

// Custom card view for displaying summary items
struct SummaryCard: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PreviewRideView(traveledDistance: 15000, seconds: 12202)
}
