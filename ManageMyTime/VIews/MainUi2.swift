//
//  MainUi2.swift
//  ManageMyTime
//
//  Created by רן א on 23/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

import SwiftUI

struct MainUI2: View {
    
    @State var settingsFlag=false
    @State var addTaskFlag=false
    @State var dailyViewFlag=false
    @State var weeklyScheduleFlag=false
    @State var listFlag=false
    @State var active=false
    @State var toggleActive=false
    var tempNotficationInit=["None"]
    let defaultColor=Color(.blue)
    let choosenColor=Color(hex:"#00FFF5")
  
    
    @ObservedObject var taskViewModel = TaskViewModel()
    @Environment(\.colorScheme) var colorScheme
    func setAddTaskFlag()
    {
        self.addTaskFlag=true
        self.settingsFlag=false
       
        self.dailyViewFlag=false
        self.weeklyScheduleFlag=false
        self.listFlag=false
        self.toggleActive=false
    
    }

    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing:0){
                /*if(self.toggleActive)
                {
                    HStack{
                         Spacer()
                          
                        
                        ZStack(alignment: .center){
                        
                                         
                                     
                        RoundedRectangle(cornerRadius: 100).fill(Color.green).frame(width: 50, height: 50)
                        Image(systemName: self.dailyViewFlag ? "calendar" : String(String(Date().day))+".square").resizable()
                            .frame(maxWidth: 25,maxHeight: 25).foregroundColor(self.addTaskFlag ?  self.choosenColor : self.defaultColor)
                        }.onTapGesture {
                                          withAnimation(.easeInOut(duration: 1)){
                                                  
                                                          
                                                      self.weeklyScheduleFlag.toggle()
                                                      self.dailyViewFlag.toggle()

                                                          self.settingsFlag=false
                                                          self.addTaskFlag=false
                                                
                                                          self.listFlag=false
                                               
                                          }
                        }
               
                         Spacer()
                     }
                }*/
            

            VStack(spacing:0){
                   
              
                     if(self.listFlag)
                     {
                        Rectangle().isHidden(true).frame(height:40)
                        TaskListSelector(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.latestDayChoiseIndex,geometry:geometry,addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag)
                     }
                     else if (self.addTaskFlag)
                     {
                        AddTask(taskViewModel:self.taskViewModel,listFlag:self.$listFlag,addTaskFlag:self.$addTaskFlag,notificationValues:self.taskViewModel.StringRangeCreator(start:0,end:60))
                        
                        //.transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))//.padding(.bottom,10)
                     }
                     else if(self.dailyViewFlag)
                     {
                        Rectangle().isHidden(true).frame(height:40)
                        DailyView()
                        
                     }
                else if(self.weeklyScheduleFlag)
                     {
                        Rectangle().isHidden(true).frame(height:36)
                        ScheduleViewRow(taskViewModel:self.taskViewModel)
                        
                     }
                 else if(self.settingsFlag)
                    {
                        //ButtonTestingView(taskViewModel:self.taskViewModel).transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))//.padding(.bottom,10)
                        
                       // AddRestrictedSpace().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))
                        Rectangle().isHidden(true).frame(height:44)
                        SettingsUI(selectedDensityIndex:self.taskViewModel.getSettingsValues()[0],selectedSchedulingAlgorithmIndex:self.taskViewModel.getSettingsValues()[1],taskViewModel:self.taskViewModel,addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag)//.transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))
                    }
                     else{
                          
                        TaskListSelector(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.latestDayChoiseIndex,geometry:geometry,addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag)
                    }
            }
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 0.8).shadow(radius: 5)
                .edgesIgnoringSafeArea(.horizontal)
            
            //Spacer is faster !!!
            
            
            
            
            //BottomMainMenu(settingsFlag: $settingsFlag, addTaskFlag: $addTaskFlag, dailyViewFlag: $dailyViewFlag, weeklyScheduleFlag: $weeklyScheduleFlag, listFlag: $listFlag).padding(.top,10).frame(height:20)
            
            HStack(spacing:0){
                
               
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.7)){
                             
                             self.settingsFlag=false
                             self.addTaskFlag=false
                             self.dailyViewFlag=false
                             self.weeklyScheduleFlag=false
                             self.listFlag=true
                             self.toggleActive=false
                           
                         }
            
                         
                     }) {
                          VStack{
                             Image(systemName: "rectangle.stack").resizable().shadow(radius: 1)
                                 .frame(maxWidth: 25,maxHeight: 25).foregroundColor(
                                 self.colorScheme == .dark ? self.listFlag ?  self.choosenColor : Color.blue : (self.listFlag ?  self.choosenColor : self.defaultColor))
                            Text("Main").shadow(radius: 0.3).frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(
                                self.colorScheme == .dark ? self.listFlag ?  self.choosenColor : Color.blue : (self.listFlag ?  self.choosenColor : self.defaultColor))
                         }
                     }.background(Rectangle().fill(Color.white.opacity(0))).padding(.top,12)
                  /*  Button(action: {
                        withAnimation(.easeInOut(duration: 1)){
                            self.addTaskFlag=true
                            self.settingsFlag=false
                           
                            self.dailyViewFlag=false
                            self.weeklyScheduleFlag=false
                            self.listFlag=false
                            self.toggleActive=false
                        }
                    }) {
                         VStack{
                            Image(systemName: "wand.and.stars").resizable()
                                .frame(maxWidth: 25,maxHeight: 25).foregroundColor(self.addTaskFlag ?  self.choosenColor : self.defaultColor)
                            Text("New Task").frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(self.addTaskFlag ? self.choosenColor : self.defaultColor)
                        }
                    }.background(Rectangle().fill(Color.white.opacity(0))).padding(.leading,5).padding(.top,12)
                   */
                    //Circle().fill(Color.blue).frame(width:45)
                
                 //Divider().frame(maxHeight: 75)
                    Button(action: {
                       
                             self.weeklyScheduleFlag=true
                             self.settingsFlag=false
                             self.addTaskFlag=false
                             self.dailyViewFlag=false
                           
                             self.listFlag=false
                             self.toggleActive=true
                        
                        
                        self.taskViewModel.GetAllTasks()
         
                      
                                   
                              var timeFactor=0.1
                                    var tripleTick=0
                                    for index in 6...24
                                 {
                          
                                       DispatchQueue.main.asyncAfter(deadline: .now() + timeFactor) {
                                     self.taskViewModel.hoursRange.append(index)
                                      
                                        
                                }
                                     tripleTick+=1
                                    
                                   
                                    
                                    if(tripleTick==6)
                                    {
                                        
                                        timeFactor+=0.1
                                         tripleTick=0
                                    }
                                    
                                  
                                   
                                    
                                         
                                     
                                 
                                // self.taskViewModel.hoursRange=[7...24]
                                     }
                      
                    }) {
                            VStack{
                                Image(systemName: "calendar").resizable().shadow(radius: 1)
                                .frame(maxWidth: 25,maxHeight: 25).foregroundColor(
                                self.colorScheme == .dark ? self.weeklyScheduleFlag ?  self.choosenColor : Color.blue : (self.weeklyScheduleFlag ?  self.choosenColor : self.defaultColor))
                             Text("Weekly").shadow(radius: 0.3).frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(
                             self.colorScheme == .dark ? self.weeklyScheduleFlag ?  self.choosenColor : Color.blue : (self.weeklyScheduleFlag ?  self.choosenColor : self.defaultColor))
                            }
                        }.background(Rectangle().fill(Color.white.opacity(0))).padding(.top,12)
               // Divider().frame(maxHeight: 75)
                Button(action: {
                   
                            self.dailyViewFlag=true
                            self.settingsFlag=false
                            self.addTaskFlag=false
                
                            self.weeklyScheduleFlag=false
                            self.listFlag=false
                            self.toggleActive=true
                      
                        
                    }) {
                         VStack{
                            Image(systemName: String(String(Date().day)+".square")).resizable().shadow(radius: 1)
                              .frame(maxWidth: 25,maxHeight: 25).foregroundColor(
                              self.colorScheme == .dark ? self.dailyViewFlag ?  self.choosenColor : Color.blue : (self.dailyViewFlag ?  self.choosenColor : self.defaultColor))
                            Text("Daily").shadow(radius: 0.3).frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(
                            self.colorScheme == .dark ? self.dailyViewFlag ?  self.choosenColor : Color.blue : (self.dailyViewFlag ?  self.choosenColor : self.defaultColor))
                        }
                }.background(Rectangle().fill(Color.white.opacity(0))).padding(.top,12)
           //  Divider().frame(maxHeight: 75)
             
              //  Divider().frame(maxHeight: 75)
                Button(action: {
                    withAnimation(.easeInOut(duration: 1)){
                            self.settingsFlag=true
                            
         
                            self.addTaskFlag=false
                            self.dailyViewFlag=false
                            self.weeklyScheduleFlag=false
                            self.listFlag=false
                            self.toggleActive=false
                        
                        }
                    }) {
                            VStack{
                                  Image(systemName: "gear").resizable().shadow(radius: 1)
                                       .frame(maxWidth: 25,maxHeight: 25).foregroundColor(
                                       self.colorScheme == .dark ? self.settingsFlag ?  self.choosenColor : Color.blue : (self.settingsFlag ?  self.choosenColor : self.defaultColor))
                                Text("Settings").shadow(radius: 0.3).frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(
                                self.colorScheme == .dark ? self.settingsFlag ?  self.choosenColor : Color.blue : (self.settingsFlag ?  self.choosenColor : self.defaultColor))
                            }
                }.background(Rectangle().fill((Color.white.opacity(0)))).padding(.top,12)
                               
                    
            }
                

              //Divider()
                
                }.onAppear{  self.taskViewModel.retrieveAllTasks()
                    self.taskViewModel.retrieveAllTasksByHour()
                    self.taskViewModel.intialValuesSetup()
                    self.listFlag=true
            }.edgesIgnoringSafeArea(.vertical)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    
      // Spacer()
            }
            //.padding(.bottom,-25)
            .background(Color(hex:"#f9f9f9").opacity(0.1))/*.background(    LinearGradient(
        gradient: Gradient(colors: [Color(hex:"#00d2ff"),Color(hex:"#3a7bd5")]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                 //self.color,.purple,.purple,.purple
                    startPoint: .bottomLeading,
                  endPoint:.bottomTrailing
                ))*/
        
        
    }
}

struct MainUI2_Previews: PreviewProvider {
    static var previews: some View {
        MainUI2()
    }
}
