//
//  Test4.swift
//  ManageMyTime
//
//  Created by רן א on 23/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct MultiPicker: View  {

    
    typealias Label = String
    typealias Entry = String

 
    
    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]
    
    let stringValue1 : String
    let stringValue2 : String
    let stringValue3 : String

    
    var body: some View {
        GeometryReader { geometry in
       
                
                HStack {
           
                    ForEach(0..<self.data.count, id: \.self) { column in
                        VStack {
                  
                            Text(self.data[column].0).font(Font.custom("MarkerFelt-Wide", size: 16))
                    
                            
                            Picker("", selection: self.$selection[column]) {
                                ForEach(0..<self.data[column].1.count, id: \.self) { row in
                                    Text(verbatim: self.data[column].1[row])
                                    .tag(self.data[column].1[row])
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: geometry.size.width / 3, height: geometry.size.height)
                            .clipped()
                        }
                    }
                
        
            }
        }
    }
}






