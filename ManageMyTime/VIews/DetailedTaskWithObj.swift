//
//  DetailedTaskWithObj.swift
//  ManageMyTime
//
//  Created by רן א on 05/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DetailedTaskWithObj: View {
    
    //@Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
   @ObservedObject var taskViewModel=TaskViewModel()
    
    
    @Binding var displayItem:Bool
    
    var taskName : String
    var importance : String
    var dueDate : Date
    var notes :String
    var asstimatedWorkTimeHour : Int
    var asstimatedWorkTimeMinutes : Int
    var startTimeHour:Int
    var startTimeMinutes:Int
    var endTimeHour:Int
    var endTimeMinutes:Int
    var day:Int
    var month:Int
    var year:Int
   
   var taskId:UUID
    var color:String
    
    var helper = HelperFuncs()
    
    //var task :Task

    
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
                    Text(self.taskName).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                    
                }
            
            
              
                HStack {
                    Text("Due Date: ")
                    Text(helper.dateToString(date: dueDate)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
                HStack {
                    Text("Importance: ")
                    Text(self.importance).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
            
              HStack {
                    Text("Work Time: ")
                    ZStack{
                        Text(String(self.asstimatedWorkTimeHour) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)).frame(width: 180, height: 90)
                 
                        Text(String(self.asstimatedWorkTimeMinutes) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                    }
                    
                }
               
                HStack {
                    Text("Note: ")
                    Text(self.notes).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                }
                
             HStack {
                        Text("Start Time: ")
                    Text(String(self.startTimeHour)+":"+String(self.startTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                            }
                 HStack {
                        Text("End Time: ")
                             Text(String(self.endTimeHour)+":"+String(endTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                 }
        
                 VStack {
                HStack {
                                  Text("day: ")
                                    Text(String(self.day)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                
                HStack {
                                  Text("Month: ")
                                       Text(String(self.month)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                
                
                HStack {
                                  Text("Year: ")
                                       Text(String(self.year)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)
                           }
                }
            }   .frame( maxWidth: .infinity, maxHeight: .infinity)
          
             Spacer()
          
     
                
         }
            }.background(LinearGradient(
                gradient: Gradient(colors: [.white,self.taskViewModel.getTaskColor(color:self.color)]),
              startPoint: UnitPoint(x: 0.2, y: 0.4),
              endPoint:UnitPoint(x: 0.1, y: 0.1)
            )).onTapGesture {
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
