//
//  ColorPicker.swift
//  ManageMyTime
//
//  Created by רן א on 13/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct ColorPicker: View {
       @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var colorArray:[Color] = [Color(hex:"#73C2FB"),Color(hex:"#72DCFF"),Color(hex:"#8DFCFF"),Color(hex:"#007FFF"),Color(hex:"#0018F9"),Color(hex:"#000080"),Color(hex:"#AAAAFF"),Color(hex:"#6F6FFF"),Color(hex:"#5B59BA"),Color(hex:"#CC99FF"),Color(hex:"#A54DFF"),Color(hex:"#7F00FF"),Color(hex:"#FFAADF"),Color(hex:"#FF6FC9"),Color(hex:"#FF34B3"),Color(hex:"#EEA7D3"),Color(hex:"#E065B2"),Color(hex:"#CD2990"),Color(hex:"#F19499"),Color(hex:"#E64049"),Color(hex:"#B0171F"),Color(hex:"#FDD4B4"),Color(hex:"#FBB782"),Color(hex:"#FA9A50"),Color(hex:"#8B8989")]
    
    @Binding var colorChoise:Color
    
    var body: some View {
        
        List(colorArray,id:\.self)
        {
            color in
            
            Button(action:{ self.colorChoise=color
                               self.mode.wrappedValue.dismiss()})
                {
                 
                RoundedRectangle(cornerRadius: 20).fill(color)
            
            }
            
            
            
        }
            
        
        
        
    }
}

/*struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker()
    }
}*/
