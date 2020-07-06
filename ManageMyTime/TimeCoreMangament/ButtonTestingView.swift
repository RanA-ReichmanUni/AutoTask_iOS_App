//
//  ButtonTestingView.swift
//  ManageMyTime
//
//  Created by רן א on 06/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI



struct ButtonTestingView: View {
    
    var timeManager=TimeManagementCore()
    
    var body: some View {
        
        VStack {
            Button(action: {self.timeManager.createData(taskName: "littleTestingTask", importance: "High", asstimatedWorkTime: 60, dueDate: Date(), notes: "Some notes")}) {
                Text("Click to create space")
            }
            
            Button(action: {try? self.timeManager.retrieveAllSpaces()}) {
                    Text("Click to retrieve space")
                }
            
            Button(action: {try? self.timeManager.deleteSpace(assignedTaskName: "littleTestingTask")}) {
                               Text("Click to retrieve space")
                           }
        }
    }
}

struct ButtonTestingView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTestingView()
    }
}
