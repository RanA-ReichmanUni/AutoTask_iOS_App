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
    @State private var selection = 1
    var body: some View {
        NavigationView {
        
        
        Form{
            
         Picker(selection: $selection, label: Text("Day")) {
                        Text("Sunday").tag(1)
                        Text("Monday").tag(2)
                        Text("Tuesday").tag(3)
                        Text("Wendsday").tag(4)
                        Text("Thursday").tag(5)
                        Text("Friday").tag(6)
                        Text("Saturday").tag(7)

                    }

        }
        }
    }
}

struct RestrictedSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        RestrictedSpaceView()
    }
}
