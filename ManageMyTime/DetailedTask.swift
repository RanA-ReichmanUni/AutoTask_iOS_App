//
//  DetailedTask.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DetailedTask: View {
    
    var helper = HelperFuncs()
    
    var task :Task
    
    var body: some View {
        
               VStack {
             Image("pink-Circle")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
            
             
                HStack {
                    
                    Text("Name: ")
                    Text(task.taskName as! String).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                    
                }
            
            
                
                HStack {
                    Text("Due Date: ")
                    Text(helper.dateToString(date: task.dueDate)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
                HStack {
                    Text("Importance: ")
                    Text(task.importance).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
            
                HStack {
                    Text("Work Time: ")
                    Text(String(task.asstimatedWorkTime) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
                HStack {
                    Text("Note: ")
                    Text(task.notes as! String).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
              
             Spacer()
          
         }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
/*
struct DetailedTask_Previews: PreviewProvider {
    


    static var previews: some View {
        
        DetailedTask()
        
    }
}

*/
