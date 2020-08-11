//
//  TaskList.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct TaskList: View {
    
    //var taskData : Task
   // var taskViewModel = TaskViewModel()
    
     @EnvironmentObject var taskViewModel:TaskViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var helper = HelperFuncs()

    var body: some View {

  
            VStack{
                List(taskViewModel.allTasks, id: \.self) { task in
                    
                    NavigationLink(destination: DetailedTaskUI( taskName: task.taskName,importance: task.importance!,dueDate: task.dueDate,notes: task.notes!, asstimatedWorkTimeHour: task.asstimatedWorkTime.hour,asstimatedWorkTimeMinutes:task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes,day:task.date.day,month:task.date.month,year:task.date.year,taskId:task.id,color:self.taskViewModel.getTaskColor(task:task))){
                   
                        CardTaskRow(taskName1: task.taskName, dueDate1: self.helper.dateToString(date: task.dueDate), importance1: task.importance!, workTimeHour: task.asstimatedWorkTime.hour, workTimeMinutes: task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes, scheduledDate: [self.helper.dateToString(date: task.date)], color: self.taskViewModel.getTaskColor(task:task)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                              
                               /*.padding(.top, -6)
                               .padding(.bottom, -6)
                               .padding(.leading, -18)
                               .padding(.trailing, -18)*/
                       /* TaskRow(taskName1: task.taskName , dueDate1: self.helper.dateToString(date: task.dueDate) , importance1: task.importance!,color:self.taskViewModel.getTaskColor(task:task))*/
                            }
                             
                }
                      .navigationBarTitle(Text("Active Tasks").foregroundColor(.green))
                        
                        
                        Button(action: {
                                           
                                self.taskViewModel.retrieveAllTasks()
                                                    
                                                                     
                                    }) {
                                            Text("Retrieve")
                                        }
                
            }.onAppear{self.taskViewModel.retrieveAllTasks()}
             
            
         
        
       
        
    }
}


/*struct TaskList_Previews: PreviewProvider {
    
      @ObservedObject var taskViewModel = TaskViewModel()
    
    static var previews: some View {

        TaskList(taskViewModel:taskViewModel)
    }
}
*/
