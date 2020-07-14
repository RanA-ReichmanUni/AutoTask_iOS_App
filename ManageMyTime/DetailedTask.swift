//
//  DetailedTask.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DetailedTask: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var taskViewModel : TaskViewModel
    
    var taskName : String

    var helper = HelperFuncs()
    
    //var task :Task
  
    var importance : String
    var dueDate : Date
    var notes :String
    var asstimatedWorkTime : Int
    var startTimeHour:Int
    var startTimeMinutes:Int
    var endTimeHour:Int
    var endTimeMinutes:Int
    var day:Int
    var month:Int
    var year:Int
    
    var body: some View {
        ScrollView{
        VStack{
               VStack {
             Image("pink-Circle")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
            
             
                HStack {
                    
                    Text("Name: ")
                    Text(taskName).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                    
                }
            
            
              
                HStack {
                    Text("Due Date: ")
                    Text(helper.dateToString(date: dueDate)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
                HStack {
                    Text("Importance: ")
                    Text(importance).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
            
                HStack {
                    Text("Work Time: ")
                    Text(String(asstimatedWorkTime) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
                HStack {
                    Text("Note: ")
                    Text(notes as! String).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
                HStack {
                        Text("Start Time: ")
                       Text(String(startTimeHour)+":"+String(startTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                            }
                 HStack {
                        Text("End Time: ")
                             Text(String(endTimeHour)+":"+String(endTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                 }
        
                 VStack {
                HStack {
                                  Text("day: ")
                                       Text(String(day)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                
                HStack {
                                  Text("Month: ")
                                       Text(String(month)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                
                
                HStack {
                                  Text("Year: ")
                                       Text(String(year)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                }
        }
          
             Spacer()
          
                Button(action: {
                                 
                self.taskViewModel.deleteTask(taskName: self.taskName)

                self.mode.wrappedValue.dismiss()
             
                                                           
                                                          }) {
                                                                      
                                                              Text("Delete")
                                                          }
                
         }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
/*
struct DetailedTask_Previews: PreviewProvider {
    


    static var previews: some View {
        
        DetailedTask()
        
    }
}

*/
