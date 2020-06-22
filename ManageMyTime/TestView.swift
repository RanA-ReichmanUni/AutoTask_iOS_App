//
//  TestView.swift
//  ManageMyTime
//
//  Created by רן א on 22/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TestView: View {
   var importanceValues = ["1", "2", "3", "4", "5"]
   @State private var selectedImportance = 3

   var body: some View {
      VStack {
         Picker(selection: $selectedImportance, label: Text("Importance")) {
            ForEach(0 ..< importanceValues.count) {
               Text(self.importanceValues[$0])
            }
         }
         Text("You selected: \(importanceValues[selectedImportance])")
      }
   }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
