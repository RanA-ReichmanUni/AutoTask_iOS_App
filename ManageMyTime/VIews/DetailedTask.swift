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
    
    @EnvironmentObject var taskViewModel:TaskViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var taskName : String

    var helper = HelperFuncs()
    
    //var task :Task
  
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
  
    var color: Color
    

    
    var body: some View {
        ScrollView{
        VStack{
               VStack {
                
               /* VStack{
                    Image("pink-Circle")
                         .resizable()
                         .frame(width: 50, height: 50)
                         .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
               
                }*/
                HStack{
                    Spacer()
                Image(systemName: "rectangle.grid.2x2.fill")
                                                         .resizable()
                    .frame(width: 65, height: 50).padding(.top,10)
                                                        // .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
                        .foregroundColor(self.color)
                    Spacer()
                }

     
                HStack {
                    
                    Text("Name: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(taskName).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    
                }
                
    
            
              
                HStack {
                    Text("Due Date: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(helper.dateToString(date: dueDate)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                }
                
                HStack {
                    Text("Importance: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(importance).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                }
            
                HStack {
                    Text("Work Time: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    ZStack{
                    Text(String(asstimatedWorkTimeHour) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                 
                     Text(String(asstimatedWorkTimeMinutes) ).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    }
                    
                }
                
                HStack {
                    Text("Note: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(notes).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width:180,height:200)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                }
                
                HStack {
                        Text("Start Time: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                       Text(String(startTimeHour)+":"+String(startTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                            }
                 HStack {
                        Text("End Time: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                             Text(String(endTimeHour)+":"+String(endTimeMinutes)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                 }
        
                 VStack {
                HStack {
                                  Text("day: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                       Text(String(day)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                
                HStack {
                                  Text("Month: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                       Text(String(month)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                
                
                HStack {
                                  Text("Year: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                       Text(String(year)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                }
        }.frame( maxWidth: .infinity, maxHeight: .infinity)
          
   
                
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).background(self.color.opacity(0)).clipShape(RoundedRectangle(cornerRadius: 15))        }
    }
}
/*
struct DetailedTask_Previews: PreviewProvider {
    


    static var previews: some View {
        
        DetailedTask()
        
    }
}

*/

