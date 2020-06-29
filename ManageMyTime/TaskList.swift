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
        
        
        VStack {
            /*List {
                     TaskRow(taskName: "Algebra execrise 1",dueDate: "22/16/20",importance: "VeryHigh")
                
                  TaskRow(taskName: "Algebra execrise 1",dueDate: "22/16/20",importance: "VeryHigh")
            }
            
            */
      
       
        
            
                NavigationView {
                    
                   List(Array(taskViewModel.allTasks), id: \.self) { task in
                    NavigationLink(destination: DetailedTask(task:task)){
                        TaskRow(taskName1: task.taskName as! String, dueDate1: self.helper.dateToString(date: task.dueDate) , importance1: task.importance)
                        }
                         
                     }
                  .navigationBarTitle(Text("Active Tasks"))
             }
            
              Button(action: {
                    
            
                                   self.taskViewModel.retrieveAllTasks()
                             
                                              
                                             }) {
                                                         
                                                 Text("Retrieve")
                                             }
        }
       
        
    }
}


struct TaskList_Previews: PreviewProvider {
    

    
    static var previews: some View {
      
        TaskList()
    }
}
