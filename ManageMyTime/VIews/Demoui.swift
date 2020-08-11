//
//  Demoui.swift
//  ManageMyTime
//
//  Created by רן א on 11/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI
struct Demoui: View {
    @State private var showingAlert = false

    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            Text("Show Alert")
        }
        .alert(isPresented:$showingAlert) {
            Alert(title: Text("Are you sure you want to delete this?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {
                    print("Deleting...")
            }, secondaryButton: .cancel())
        }
    }
}
