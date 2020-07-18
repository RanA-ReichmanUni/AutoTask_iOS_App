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

    
    var body: some View {
         
   
                    HStack {
                 
                        if(self.hourTasks.isEmptySlot)
                        {
                            HStack {
                                TestTaskRow(taskName: "", heightFactor:CGFloat(1.5),fillColor: Color(.white)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                            
                            }
                              
                        }
                        else{
                            VStack {
                          
                           
                        ForEach(self.hourTasks.tasks){
                             task in
           
                                   // DviderTest(offSet:self.offSet)
                            if(task.taskName=="")
                            {
                                TestTaskRow(taskName: task.taskName, heightFactor:   task.heightFactor,fillColor: Color(.white)).padding(EdgeInsets(top: 7, leading: 0, bottom:0.1, trailing: 0))
                            }
                            else{
                                TestTaskRow(taskName: task.taskName, heightFactor:   task.heightFactor,fillColor: Color(.systemTeal)).padding(EdgeInsets(top: 7, leading: 0, bottom:0.1, trailing: 0))
                                    
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
