//
//  TempNavigator.swift
//  ManageMyTime
//
//  Created by רן א on 21/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TempNavigator: View {
    var body: some View {
      NavigationView {
        List(){
            
      
                
                NavigationLink(destination:ScheduleViewRow()){
                    
                    Text("Weekly Schedule")
                }
                
                NavigationLink(destination:TaskList()){
                                 
                    Text("Task List")
                }
                
                NavigationLink(destination:ButtonTestingView()){
                                                
                    Text("Button Testing")
                }
                
                
          
            
        }
            
            
        }
    }
}

struct TempNavigator_Previews: PreviewProvider {
    static var previews: some View {
        TempNavigator()
    }
}
