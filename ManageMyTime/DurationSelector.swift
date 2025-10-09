//
//  test5.swift
//  ManageMyTime
//
//  Created by רן א on 23/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DurationSelector: View {
    
    @State var data: [(String, [String])] = [
        ("One", Array(0...30).map { "\($0)" }),
        ("Two", Array(0...23).map { "\($0)" }),
        ("Three", Array(0...60).map { "\($0)" })
    ]
    @State var selection: [String] = [0, 0, 0].map { "\($0)" }
    
   
    
    var body: some View {
 
        VStack(alignment: .center) {
            Text("Asstimated Work Time")
            HStack{
                   Text("Days                         ")
                   Text("Hours                 ")
                   Text(" Minutes")
               }
            MultiPicker(data: data, selection: $selection,stringValue1: "Days",stringValue2:"Hours",stringValue3:"Minutes").frame(height: 300)
        
        }
    }
}

struct DurationSelector_Previews: PreviewProvider {
    static var previews: some View {
        DurationSelector()
    }
}
