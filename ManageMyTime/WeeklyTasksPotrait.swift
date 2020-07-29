//
//  WeeklyTasksPotrait.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//


import SwiftUI

struct WeeklyTasksPotrait: View {
    
    var timeChar : String
      
    var hourTasks : TasksPerHourPerDay

    var taskViewModel = TaskViewModel()
    
    var body: some View {
         
   
                    HStack {
                 
                        if(self.hourTasks.isEmptySlot)
                        {
                        GeometryReader { geometry in
                                HStack {
                                    TaskUnitPotrait(taskName: "", heightFactor:CGFloat(1.5),fillColor: Color(.white)).frame(width: geometry.size.width, height:  geometry.size.height/2).padding(EdgeInsets(top: 2, leading: 3, bottom: 4, trailing: 2))
                                
                                }
                            }
                              
                        }
                        else{
                       
                            VStack {
                          
                           
                        ForEach(self.hourTasks.tasks){
                             task in
            GeometryReader { geometry in
                                   // DviderTest(offSet:self.offSet)
                            if(task.taskName=="")
                            {
                                TaskUnitPotrait(taskName: task.taskName, heightFactor:   task.heightFactor,fillColor: Color(.white)).frame(width: geometry.size.width, height:  geometry.size.height/2).padding(EdgeInsets(top: 2, leading: 3, bottom: 4, trailing: 2))
                            }
                            else{
                                
                                TaskUnitPotrait(taskName: task.taskName, heightFactor:   task.heightFactor,fillColor: task.color).frame(width: geometry.size.width, height:  geometry.size.height).padding(EdgeInsets(top: 2, leading: 2, bottom: 4, trailing: 4))
                                    
                                        }
                                   
                                    }
                                }
                            }
                        }
                    
                }
              
    }
}
/*
struct WeeklyTasksPotrait_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTasksRow(timeChar: "23" ,hourTasks: ["math","hello"])
    }
}
*/
