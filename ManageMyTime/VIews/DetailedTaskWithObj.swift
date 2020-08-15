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
    @Environment(\.colorScheme) var colorScheme

   // var lightModeGradient:LinearGradient=
    
    //var task :Task

  
    var body: some View {
        ScrollView{
        VStack{
             
             Image("pink-Circle")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
             
                HStack {
                    
                    Text("Name: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(self.taskName).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    
                }
            
            
              
                HStack {
                    Text("Due Date: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(helper.dateToString(date: dueDate)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                }
                
                HStack {
                    Text("Importance: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(self.importance).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                }
            
              HStack {
                    Text("Work Time: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    ZStack{
                        Text(String(self.asstimatedWorkTimeHour) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                 
                        Text(String(self.asstimatedWorkTimeMinutes) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    }
                    
                }
               
                HStack {
                    Text("Note: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(self.notes).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                }
                
             HStack {
                        Text("Start Time: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(String(self.startTimeHour)+":"+String(self.startTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                            }
                 HStack {
                        Text("End Time: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                             Text(String(self.endTimeHour)+":"+String(endTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                 }
        
                 VStack {
                HStack {
                                  Text("day: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                    Text(String(self.day)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                
                HStack {
                                  Text("Month: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                       Text(String(self.month)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                
                
                HStack {
                                  Text("Year: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                       Text(String(self.year)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                
            }   .frame( maxWidth: .infinity, maxHeight: .infinity)
          
             Spacer()
          
     
                
         }//Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518")
            }.background(
                self.colorScheme == .dark ? ( LinearGradient(
                    gradient: Gradient(colors: [Color("#f1f1f1"),Color("#d1d1d1"),Color("#ffffff"),self.taskViewModel.getTaskColor(color:self.color)]),
                             startPoint: UnitPoint(x: 0.2, y: 0.4),
                             endPoint:.bottom
                           )) :(
                LinearGradient(
                gradient: Gradient(colors: [Color.white,self.taskViewModel.getTaskColor(color:self.color)]),
              startPoint: UnitPoint(x: 0.2, y: 0.4),
              endPoint:.bottom
            ))).onTapGesture {
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
