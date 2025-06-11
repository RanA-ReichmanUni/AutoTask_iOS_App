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
    var asstimatedWorkTimeHour : String
    var asstimatedWorkTimeMinutes : String
    var startTimeHour:String
    var startTimeMinutes:String
    var endTimeHour:String
    var endTimeMinutes:String
    var day:Int
    var month:Int
    var year:Int
   
   var taskId:UUID
    var color:Color
    
    var helper = HelperFuncs()
    @Environment(\.colorScheme) var colorScheme

   // var lightModeGradient:LinearGradient=
    
    //var task :Task

  
    var body: some View {
        ScrollView{
        VStack{
             
            /* Image("pink-Circle")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))*/
      
            HStack{
                Spacer()
            Image(systemName: "rectangle.grid.2x2.fill")
                                                     .resizable()
                .frame(width: 65, height: 50).padding(.top,10).padding(.bottom,10)
                                                    // .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
                    .foregroundColor(self.color)
                Spacer()
            }.padding(.top,5)
            Spacer()
            
                HStack {
                    Spacer()
                   // Text("Name: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(self.taskName) .font(Font.custom("Chalkduster", size: 30)).frame(width:300,height:200) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                      Spacer()
                    
                    
                }.padding(.bottom,10)
            
            
              
                HStack {
                  //  Spacer()
                    Text("Due Date: ").font(Font.custom("Chalkduster", size: 20)).padding(.trailing,30).padding(.leading,70)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                   // Spacer()
                    Text(helper.dateToStringNormalized(date: dueDate)
                    ).foregroundColor(Color.red).font(Font.custom("Chalkduster", size: 18)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                      Spacer()
                }
                
              /*  HStack {
                    Text("Importance: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    Text(self.importance).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                      Spacer()
                }*/
            
              HStack {
                //Spacer()
                Text("Work Time: ").font(Font.custom("Chalkduster", size: 20)).padding(.trailing,30).padding(.leading,70)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
      
                        //Spacer()
                        Text(String(self.asstimatedWorkTimeHour)+":"+String(self.asstimatedWorkTimeMinutes) ).font(Font.custom("Chalkduster", size: 18)) .frame(height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                        
                        
                          
                    
                    Spacer()
                }
               
         
                
          
        
                 VStack {
                HStack {
                       // Spacer()
                    Text("Scheduled: ").font(Font.custom("Chalkduster", size: 20)).padding(.leading,70)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                    //Spacer()
                    HStack(spacing:0){
                       // Text(String(self.day)+"/").font(.system(size: 20))
                        Text(String(self.day)+"/"+String(self.month)+"/").font(Font.custom("MarkerFelt-Wide", size: 18))
                        Text(String(self.year)).font(Font.custom("MarkerFelt-Wide", size: 18))
                        
                       
                        }.frame(height: 90)
                       Spacer()
                       //.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                    
                    
                HStack {
                     //Spacer()
                             Text("Starts At: ").font(Font.custom("Chalkduster", size: 20)).padding(.trailing,30).padding(.leading,70)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                  //  Spacer()
                         Text(String(self.startTimeHour)+":"+String(self.startTimeMinutes)).font(Font.custom("Chalkduster", size: 18)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                       Spacer()
                                 }
                      HStack {
                         //Spacer()
                             Text("Ends At: ").padding(.trailing,30).padding(.leading,70).font(Font.custom("Chalkduster", size: 20))//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                       // Spacer()
                                  Text(String(self.endTimeHour)+":"+String(endTimeMinutes)).font(Font.custom("Chalkduster", size: 18)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           Spacer()
                      }
                
                /*HStack {
                                  Text("Month: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                       Text(String(self.month)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }
                
                
                HStack {
                                  Text("Year: ")//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                                       Text(String(self.year)).font(.system(size: 20)).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: 180, height: 90)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           }*/
                
            }
          
            Divider()
            HStack {
                
                    // Spacer()
                     Text("Notes: ").font(Font.custom("Chalkduster", size: 20)).padding(.trailing,30).padding(.leading,70)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                
                    //Spacer()
                     Text(self.notes).font(Font.custom("Chalkduster", size: 18)).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(height: 150)//.foregroundColor(self.colorScheme == .dark ? Color.black : Color.black)
                           Spacer()
                 }
            
             Spacer()
          
     
                
         }.frame( maxWidth: .infinity, maxHeight: .infinity)//Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518")
            }.background(
                self.colorScheme == .dark ? ( LinearGradient(
                    gradient: Gradient(colors: [Color("#f1f1f1"),Color("#d1d1d1"),Color("#ffffff"),self.color]),
                             startPoint: UnitPoint(x: 0.2, y: 0.4),
                             endPoint:.bottom
                           )) :(
                LinearGradient(
                gradient: Gradient(colors: [Color.white,self.color]),
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
