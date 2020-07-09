//
//  ButtonTestingView.swift
//  ManageMyTime
//
//  Created by רן א on 06/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI



struct ButtonTestingView: View {
    
    var tm=Core()
    
    var body: some View {
        
        VStack {
                   Button(action: {self.tm.createFreeSpace()}) {
                     Text("Click to create space")
                 }
                 
                 Button(action: {try? self.tm.retrieveAllFreeSpaces()}) {
                         Text("Click to retrieve space")
                     }
                 
                 Button(action: {try? self.tm.deleteSpace(assignedTaskName: "littleTestingTask")}) {
                                    Text("Click to delete space")
                                }
        }
    }
}

struct ButtonTestingView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTestingView()
    }
}
