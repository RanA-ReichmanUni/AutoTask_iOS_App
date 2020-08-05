//
//  WeeklyTasksRow.swift
//  ManageMyTime
//
//  Created by רן א on 03/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct WeeklyTasksRow: View {
    
    var timeChar : String
      
    var hourTasks : TasksPerHourPerDay

    var taskViewModel = TaskViewModel()
    
    var body: some View {
         
   
                    HStack {
                 
                        if(self.hourTasks.isEmptySlot)
                        {
                        GeometryReader { geometry in
                                HStack {
                                    TestTaskRow(taskName: "", heightFactor:CGFloat(1.5),fillColor: Color(.white)).frame(width: geometry.size.width, height:  geometry.size.height/2).padding(EdgeInsets(top: 2, leading: 0, bottom: 4, trailing: 0))
                                
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
                                TestTaskRow(taskName: task.taskName,taskId:task.id, heightFactor:   task.heightFactor,fillColor: Color(.white)).frame(width: geometry.size.width, height:  geometry.size.height/2).padding(EdgeInsets(top: 2, leading: 0, bottom: 4, trailing: 0))
                            }
                            else{
                                
                                TestTaskRow(taskName: task.taskName,taskId:task.id, heightFactor:   task.heightFactor,fillColor: task.color).frame(width: geometry.size.width, height:  geometry.size.height).padding(EdgeInsets(top: 2, leading: 0, bottom: 4, trailing: 0))
                                    
                                        }
                                   
                                    }
                                }
                            }
                        }
                    
                }
              
    }
}
/*
struct WeeklyTasksRow_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTasksRow(timeChar: "23" ,hourTasks: ["math","hello"])
    }
}
*/
