//
//  PickerView.swift
//  ManageMyTime
//
//  Created by רן א on 17/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PickerView: View {
    
    @State var data: [(String, [String])] = [
           ("Hour", Array(0...24).map { "\($0)" }),
           ("Min", Array(0...59).map { "\($0)" })
       ]
       @State var selection: [String] = [0, 0, 0].map { "\($0)" }
     @State var selection2: [String] = [0, 0, 0].map { "\($0)" }
    
    var body: some View {
        HStack{
            VStack{
                Text("From:").foregroundColor(Color.red).padding(.bottom,4)
                
                MultiPicker(data: self.data, selection: self.$selection,stringValue1: "Hour",stringValue2:"                        Minutes",stringValue3:"").frame(width:100,height: 200).padding()
            }
        
         VStack{
            Text("To:").foregroundColor(Color.red).padding(.bottom,4)
              MultiPicker(data: self.data, selection: self.$selection2,stringValue1: "Hour",stringValue2:"                        Minutes",stringValue3:"").frame(width:100,height: 200).padding()
          }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
