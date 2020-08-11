//
//  RestrictedSpaceView.swift
//  ManageMyTime
//
//  Created by רן א on 29/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct RestrictedSpaceView: View {
    @State private var age = 18
   // @State private var selection = 1
   
@State private var numberOfControlls = 0
    
  
    @State var data: [(String, [String])] = [
         ("Hours", Array(0...20).map { "\($0)" }),
         ("Minutes", Array(0...59).map { "\($0)" })
     ]
     @State var selection: [String] = [0, 0, 0].map { "\($0)" }
    
    var body: some View {

        
        
          VStack {
          Button(action: {
              self.numberOfControlls += 1
          }) {
              Text("Tap to create")
          }
          ForEach(0 ..< numberOfControlls, id: \.self) { _ in
            MultiPicker(data: self.data, selection: self.$selection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()
          }
      }
        
    }
}

struct RestrictedSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        RestrictedSpaceView()
    }
}
