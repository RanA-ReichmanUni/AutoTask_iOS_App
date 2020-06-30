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
    
     @ObservedObject var taskViewModel = TaskViewModel()

    var helper = HelperFuncs()

    var body: some View {

        NavigationView {
            VStack{
                List(taskViewModel.allTasks, id: \.self) { task in
                    
                    NavigationLink(destination: DetailedTask(taskViewModel: self.taskViewModel, taskName: task.taskName,importance: task.importance,dueDate: task.dueDate,notes: task.notes as! String, asstimatedWorkTime: task.asstimatedWorkTime)){
                            TaskRow(taskName1: task.taskName as! String, dueDate1: self.helper.dateToString(date: task.dueDate) , importance1: task.importance)
                            }
                             
                         }
                      .navigationBarTitle(Text("Active Tasks").foregroundColor(.green))
                        
                        
                        Button(action: {
                                           
                                self.taskViewModel.retrieveAllTasks()
                                                    
                                                                     
                                    }) {
                                            Text("Retrieve")
                                        }
                
                        }
             }
            
         
        
       
        
    }
}


struct TaskList_Previews: PreviewProvider {
    

    
    static var previews: some View {
      
        TaskList()
    }
}
