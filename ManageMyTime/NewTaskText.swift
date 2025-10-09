//
//  NewTaskText.swift
//  ManageMyTime
//
//  Created by רן א on 23/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct NewTaskText: View {
    var body: some View {
        HStack {
            
            Image(systemName: "pencil")
            Text("New Task")
        }
    }
}

struct NewTaskText_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskText()
    }
}
