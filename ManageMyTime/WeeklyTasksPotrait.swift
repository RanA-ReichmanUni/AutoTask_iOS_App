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

    @ObservedObject var taskViewModel=TaskViewModel()
    
    var body: some View {
         
   
                    HStack {
                 
                        if(self.hourTasks.isEmptySlot)
                        {
                        GeometryReader { geometry in
                                HStack {
                                    /*TaskUnitPotrait(taskViewModel:self.taskViewModel,taskName: "", heightFactor:CGFloat(1.5),fillColor: Color(.white),opacity:1).frame(width: geometry.size.width, height:  geometry.size.height/2)//.padding(EdgeInsets(top: 2, leading: 3, bottom: 4, trailing: 2))*/
                                    Spacer()
                                
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
                               /* TaskUnitPotrait(taskViewModel:self.taskViewModel,taskName: task.taskName, heightFactor:task.heightFactor,fillColor: Color(.white),opacity:task.opacity).frame(width: geometry.size.width, height:  geometry.size.height/2)//.padding(EdgeInsets(top: 2, leading: 3, bottom: 4, trailing: 2))*/
                                Spacer()
                            }
                            else{
                                
                                TaskUnitPotrait(taskViewModel:self.taskViewModel,taskName: task.taskName,taskId:task.id, heightFactor:   task.heightFactor,fillColor: task.color,opacity:task.opacity).frame(width: geometry.size.width, height:  geometry.size.height)//.padding(EdgeInsets(top: 2, leading: 2, bottom: 4, trailing: 4))
                                    
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
