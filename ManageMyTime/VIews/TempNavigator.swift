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
            
                NavigationLink(destination:DailyView()){
                            
                            Text("Daily Schedule")
                }
            
                
                NavigationLink(destination:TaskList()){
                                 
                    Text("Task List")
                }
            
                NavigationLink(destination:AddTask()){
                                                        
                            Text("Add Task")
                }
                NavigationLink(destination:StressDailyView()){
                                                                  
                            Text("Daily Work Load")
                }
                 
                
                NavigationLink(destination:ButtonTestingView()){
                                                
                    Text("Button Testing")
                }
            NavigationLink(destination:RestrictedSpaceView()){
                                                         
                             Text("Test")
                         }
                     
                    
                  
                           
                
          .hiddenNavigationBarStyle()
            
        }.navigationBarTitle(Text("Manage My Time").foregroundColor(.green))
            
            
        }
    }
}

struct TempNavigator_Previews: PreviewProvider {
    static var previews: some View {
        TempNavigator()
    }
}


struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
