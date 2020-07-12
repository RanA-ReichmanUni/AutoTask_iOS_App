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
           Button(action: { self.tm.createCalanderSequence(startDay: 10, startMonth: 5, startYear: 2020, endDay: 20, endMonth: 3, endYear: 2021)}) {
                     Text("Click to do some high risk testing")
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
