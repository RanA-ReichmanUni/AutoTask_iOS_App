//
//  BackgroundToggleStyle.swift
//  ManageMyTime
//
//  Created by רן א on 02/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

import SwiftUI

struct BackgroundToggleStyle: ToggleStyle {
    
    var onImageName: String
    var offImageName: String
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(configuration.isOn ? onImageName : offImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.red)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
        
            
    }
}
