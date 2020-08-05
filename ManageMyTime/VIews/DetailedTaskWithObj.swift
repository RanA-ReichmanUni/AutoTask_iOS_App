//
//  DetailedTaskWithObj.swift
//  ManageMyTime
//
//  Created by רן א on 05/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DetailedTaskWithObj: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
   @ObservedObject var taskViewModel=TaskViewModel()
    
    
    @Binding var displayItem:Bool
    var taskId:UUID

    var helper = HelperFuncs()
    
    //var task :Task
 
    
    var body: some View {
        ScrollView{
        VStack{
               VStack {
             Image("pink-Circle")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0)).onAppear{self.taskViewModel.getTask(taskId:self.taskId)}
            
             
                HStack {
                    
                    Text("Name: ")
                    Text(self.taskViewModel.taskName).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                    
                }
            
            
              
                HStack {
                    Text("Due Date: ")
                    Text(helper.dateToString(date: taskViewModel.dueDate)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
                HStack {
                    Text("Importance: ")
                    Text(self.taskViewModel.importance).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
            
              HStack {
                    Text("Work Time: ")
                    ZStack{
                        Text(String(self.taskViewModel.asstimatedWorkTime.hour) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)).frame(width: 180, height: 90)
                 
                        Text(String(self.taskViewModel.asstimatedWorkTime.minutes) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                    }
                    
                }
               
                HStack {
                    Text("Note: ")
                    Text(self.taskViewModel.notes).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
             HStack {
                        Text("Start Time: ")
                    Text(String(self.taskViewModel.startTime.hour)+":"+String(self.taskViewModel.startTime.minutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                            }
                 HStack {
                        Text("End Time: ")
                             Text(String(self.taskViewModel.endTime.hour)+":"+String(taskViewModel.endTime.minutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                 }
        
                 VStack {
                HStack {
                                  Text("day: ")
                                    Text(String(self.taskViewModel.date.day)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                
                HStack {
                                  Text("Month: ")
                                       Text(String(self.taskViewModel.date.month)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                
                
                HStack {
                                  Text("Year: ")
                                       Text(String(self.taskViewModel.date.year)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                }
            }   .frame( maxWidth: .infinity, maxHeight: .infinity)
          
             Spacer()
          
     
                
         }
        }.onTapGesture {
            self.displayItem = false
        }
    }
}
/*
struct DetailedTaskWithObj_Previews: PreviewProvider {
    


    static var previews: some View {
        
        DetailedTask()
        
    }
}

*/
