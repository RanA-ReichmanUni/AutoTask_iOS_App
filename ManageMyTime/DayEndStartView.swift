//
//  DayEndStartView.swift
//  ManageMyTime
//
//  Created by רן א on 12/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DayEndStartView: View {
    
    
    @State var data: [(String, [String])] = [
        ("Hours", Array(1...23).map { "\($0)" }),
        ("Minutes", Array(0...59).map { "\($0)" })
    ]
    
    @State var fromSelection: [String] = [7, 0, 0].map { "\($0)" }
    @State var toSelection: [String] = [22, 0, 0].map { "\($0)" }
    
    
    
    var body: some View {
        Form{
           
                Spacer()
                Section(header: HStack {
                        Image(systemName:"clock").foregroundColor(.blue)
                        Text("Day Starts At: ").font(Font.custom("MarkerFelt-Wide", size: 16))
                    }) {
                       MultiPicker(data: self.data, selection: self.$fromSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()
                 }.navigationBarTitle("Add Personal Repeated Activity",displayMode: .inline)
                                           
                                   
               Section(header: HStack {
                         Image(systemName:"clock").foregroundColor(.blue)
                         Text("Day Ends In: ").font(Font.custom("MarkerFelt-Wide", size: 16))
                     }) {
                        MultiPicker(data: self.data, selection: self.$toSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()
                  }
             Spacer()
            
            
            
            
            
        }
    }
}

struct DayEndStartView_Previews: PreviewProvider {
    static var previews: some View {
        DayEndStartView()
    }
}
