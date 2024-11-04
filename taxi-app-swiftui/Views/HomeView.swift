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
    
    @AppStorage(K.Keys.languageKey) private var language = K.DefaultValue.language
    
    let timerManager = TimerManager()
    
    var body: some View {
        NavigationStack{
            VStack {
                MapViewRepresentable(locationManager: locationManager)
                    .overlay(alignment: .bottom){
                        VStack{
                            HStack{
                                VStack{
                                    if !isTracking{
                                        ActionButton(locationManager: locationManager,text: "start".translated(to: language), color: .blue, isTracking: $isTracking, showAlert: $showAlert, timerManager: timerManager, name: "Start")
                                    }else {
                                        ActionButton(locationManager: locationManager,text: "stop".translated(to: language), color: .red,  isTracking: $isTracking, showAlert: $showAlert,timerManager: timerManager, name: "Stop")
                                    }
                                }
                                
                            }
                            .padding(.bottom, 10)
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
                                        .padding(.bottom, 5)
                                }
                            }
                    }.padding(.bottom, 1)
                    .ignoresSafeArea()
                    .alert("alert".translated(to: language), isPresented: $showAlert) {
                        Button("no".translated(to: language)){
                            showAlert = false;
                        }
                        Button("yes".translated(to: language)){
                            SoundManager.shared.playSound("Stop", "wav")
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
    let name: String
        
    var body: some View {
        Button {
            if name == "Stop"{
                showAlert = true
            }else if name == "Start"{
                locationManager.startUpdatingLocation()
                SoundManager.shared.playSound("Start", "wav")
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
