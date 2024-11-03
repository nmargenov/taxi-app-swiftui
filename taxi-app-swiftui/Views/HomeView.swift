//
//  ContentView.swift
//  map-uper-test
//
//  Created by Nikolai Margenov on 2.11.24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    
    @StateObject private var locationManager = LocationManager()
    @State private var showAlert = false
    @State private var isTracking = false
    @State private var showDetailView = false
    
    @State private var traveledDistance: Double = 0.0
    @State private var seconds: Int = 0
    
    let timerManager = TimerManager()
    
    var body: some View {
        NavigationView{
            VStack {
                MapViewRepresentable(locationManager: locationManager)
                    .ignoresSafeArea()
                    .overlay(alignment: .bottom){
                        VStack{
                            HStack{
                                VStack{
                                    if !isTracking{
                                        ActionButton(locationManager: locationManager,text: "Start", color: .blue, isTracking: $isTracking, showAlert: $showAlert, timerManager: timerManager)
                                    }else {
                                        ActionButton(locationManager: locationManager,text: "Stop", color: .red,  isTracking: $isTracking, showAlert: $showAlert,timerManager: timerManager)
                                    }
                                }
                                
                            }
                            Text("Distance traveled: \(locationManager.distanceTraveled, specifier: "%.2f") meters")
                                .padding(0)
                                .padding(.bottom, 15)
                        }.frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.5))
                            .overlay{
                                if !isTracking {
                                    HStack{
                                        Spacer()
                                        NavigationLink(destination: SettingsView()) {
                                            HStack{
                                                Image(systemName: "gearshape.fill")
                                                    .font(.system(size: 35))
                                            }
                                        }
                                    }.padding(.trailing,20)
                                        .padding(.bottom, 20)
                                }
                            }
                    }.padding(.bottom, 1)
                    .ignoresSafeArea()
                    .alert("Are you sure you want to finish the current ride?", isPresented: $showAlert) {
                        Button("No"){
                            showAlert = false;
                        }
                        Button("Yes"){
                            traveledDistance = locationManager.distanceTraveled
                            locationManager.stopUpdatingLocation()
                            showAlert = false;
                            isTracking = false;
                            showDetailView = true
                            seconds = timerManager.stop()
                        }
                    }
            }
            
        }
        .sheet(isPresented: $showDetailView) {
            PreviewRideView(traveledDistance: traveledDistance, seconds: seconds)
        }
    }
}

#Preview{
    HomeView()
}


struct ActionButton: View {
    
    let locationManager:LocationManager
    let text: String
    let color: Color
    @Binding var isTracking: Bool;
    @Binding var showAlert: Bool
    let timerManager: TimerManager
    
    var body: some View {
        Button {
            if text == "Stop"{
                showAlert = true
            }else if text == "Start"{
                locationManager.startUpdatingLocation()
                isTracking = true;
                timerManager.start()
            }
        } label: {
            Text(text)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .font(.title)
        }
        .padding(.bottom, 1)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20.0, height: 0)))
        .padding(.top, 10)
        
    }
}
