//
//  LaunchView.swift
//  taxi-app-swiftui
//
//  Created by Nikolai Margenov on 4.11.24.
//

import SwiftUI

struct LaunchView: View {
    @State var isActive = false
    @State var titleText = ""
    @State var opacity = 0.3
    @State var size = 0.4
    
    var body: some View {
        if isActive{
            HomeView()
        }
        else{
            ZStack{
                Color(.blue)
                    .ignoresSafeArea()
                VStack{
                    Image("car")
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear(){
                            withAnimation(.easeIn(duration: 1.2)){
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    Text(titleText)
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                }
            }.onAppear(){
                onLoad()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    func onLoad(){
        let titleText = "Taxi app"
        var charIndex = 0.0
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false) { (timer) in
                self.titleText.append(letter)
            }
            charIndex += 1
        }
    }
    
}

#Preview {
    LaunchView()
}
