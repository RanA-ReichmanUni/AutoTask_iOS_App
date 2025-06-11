//
//  TestView3.swift
//  ManageMyTime
//
//  Created by רן א on 22/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TestView3: View {
    var frameworks = ["UIKit", "Core Data", "CloudKit", "SwiftUI"]
      @State private var selectedFrameworkIndex = 0

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedFrameworkIndex, label: Text("Favorite Framework")) {
                        ForEach(0 ..< frameworks.count) {
                            Text(self.frameworks[$0])
                        }
                    }
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}

struct TestView3_Previews: PreviewProvider {
    static var previews: some View {
        TestView3()
    }
}
