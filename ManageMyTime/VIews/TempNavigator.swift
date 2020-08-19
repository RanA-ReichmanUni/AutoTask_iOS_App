//
//  TempNavigator.swift
//  ManageMyTime
//
//  Created by רן א on 21/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TempNavigator: View {
    @ObservedObject var taskViewModel=TaskViewModel()
    @ObservedObject var restrictedSpaceViewModel=RestrictedSpaceViewModel()
    
   /* init() { // for navigation bar title color
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
    // For navigation bar background color
    UINavigationBar.appearance().backgroundColor = UIColor(Color(hex:"#2193b0"))
       }*/
    
    var body: some View {
 
      NavigationView {
        
        List(){
            
      
                
            NavigationLink(destination:ScheduleViewRow()){
                    
                    Text("Weekly Schedule")
                }
            
                NavigationLink(destination:DailyView()){
                            
                            Text("Daily Schedule")
                }
            
                //previously we didn't pass the taskViewModel
            NavigationLink(destination:TaskList(taskViewModel:taskViewModel)){
                                 
                    Text("All Tasks")
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
          
            
            NavigationLink(destination:RestrictedSpaceUI(restrictedSpaceViewModel:restrictedSpaceViewModel)){
                                                                        
                Text("RestrictedSpaces")
            }
            
            NavigationLink(destination:RestrictedDayUI()){
                                                                 
                Text("Test1")
            }
                
          /*  NavigationLink(destination:RestrictedSpaceView(numberOfControlls:0)){
                                                         
                             Text("Test")
                         }*/
                     
               
                  
                           
                
          .hiddenNavigationBarStyle()
            
        }.navigationBarTitle(Text("Manage My Time").foregroundColor(.green)).onAppear{self.taskViewModel.retrieveAllTasks()
            self.restrictedSpaceViewModel.getAllRestrictedSpace()
        }//Previouslt we didn't have on appear.
            
            
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
