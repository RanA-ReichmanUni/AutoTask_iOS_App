//
//  TwoRowsPicker.swift
//  ManageMyTime
//
//  Created by רן א on 19/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TwoRowsPicker: View  {

    
    typealias Label = String
    typealias Entry = String

 
    
    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]
    
    let stringValue1 : String
    let stringValue2 : String
    let stringValue3 : String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                HStack(alignment: .center){
                    
                    Text(self.stringValue1)
                    Text(self.stringValue2)
                    Text(self.stringValue3)
                }
                
                HStack {
           
                    ForEach(0..<self.data.count) { column in
                        Picker(self.data[column].0, selection: self.$selection[column]) {
                            ForEach(0..<self.data[column].1.count) { row in
                                Text(verbatim: self.data[column].1[row])
                                .tag(self.data[column].1[row])
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                        .clipped()
                    }
                }
            }
        }
    }
}






