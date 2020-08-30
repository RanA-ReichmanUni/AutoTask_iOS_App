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
    
    let defaultColor=Color(hex:"#f2fcfc")
    let choosenColor=Color(hex:"#00FFF5")
  
    @ObservedObject var taskViewModel = TaskViewModel()
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing:0){
  
            
            

            VStack(spacing:0){
                   
                if(self.settingsFlag)
                     {
                        ButtonTestingView().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))//.padding(.bottom,10)
                     }
                     
                     else if (self.addTaskFlag)
                     {
                         AddTask().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))//.padding(.bottom,10)
                     }
                     else if(self.dailyViewFlag)
                     {
                        DailyView().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))//.padding(.bottom,10)
                                           
                        
                     }
                else if(self.weeklyScheduleFlag)
                     {
                        ScheduleViewRow().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))//.padding(.bottom,10)
                     }
                else if(self.listFlag)
                     {
                        TaskList().transition(.scale)//.padding(.bottom,10)
                     }
                     else{
                           
                        Spacer()
                             Spacer()
                             Spacer()
                             Spacer()
                    }
            }.transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))
                
            Divider()
            
            
            
            
            
            
            //BottomMainMenu(settingsFlag: $settingsFlag, addTaskFlag: $addTaskFlag, dailyViewFlag: $dailyViewFlag, weeklyScheduleFlag: $weeklyScheduleFlag, listFlag: $listFlag).padding(.top,10).frame(height:20)
            
            HStack(spacing:0){
                
               
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)){
                            self.addTaskFlag=true
                            self.settingsFlag=false
                           
                            self.dailyViewFlag=false
                            self.weeklyScheduleFlag=false
                            self.listFlag=false
                        }
                    }) {
                         VStack{
                            Image(systemName: "wand.and.stars").resizable()
                                .frame(maxWidth: 25,maxHeight: 25).foregroundColor(self.addTaskFlag ?  self.choosenColor : self.defaultColor)
                            Text("New").frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(self.addTaskFlag ? self.choosenColor : self.defaultColor)
                        }
                    }.background(Rectangle().fill(Color.white.opacity(0))).padding(.leading,5).padding(.top,12)
                   
                    //Circle().fill(Color.blue).frame(width:45)

                 Divider().frame(maxHeight: 75)
                    Button(action: {
                        withAnimation(.ripple2()){
                             self.weeklyScheduleFlag=true
                             self.settingsFlag=false
                             self.addTaskFlag=false
                             self.dailyViewFlag=false
                           
                             self.listFlag=false
                        }
                      
                    }) {
                            VStack{
                              Image(systemName: "calendar").resizable()
                                .frame(maxWidth: 25,maxHeight: 25).foregroundColor((self.weeklyScheduleFlag ? self.choosenColor : self.defaultColor))
                             Text("Weekly").frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(self.weeklyScheduleFlag ?  self.choosenColor : self.defaultColor)
                            }
                        }.background(Rectangle().fill(Color.white.opacity(0))).padding(.top,12)
                Divider().frame(maxHeight: 75)
                Button(action: {
                        withAnimation(.easeInOut(duration: 1)){
                             self.dailyViewFlag=true
                             self.settingsFlag=false
                             self.addTaskFlag=false
                
                             self.weeklyScheduleFlag=false
                             self.listFlag=false
                        }
                    }) {
                         VStack{
                            Image(systemName: String(String(Date().day)+".square")).resizable()
                              .frame(maxWidth: 25,maxHeight: 25).foregroundColor((self.dailyViewFlag ?  self.choosenColor : self.defaultColor))
                            Text("Daily").frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(self.dailyViewFlag ?  self.choosenColor : self.defaultColor)
                        }
                }.background(Rectangle().fill(Color.white.opacity(0))).padding(.top,12)
             Divider().frame(maxHeight: 75)
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.01)){
                             self.listFlag=true
                             self.settingsFlag=false
                             self.addTaskFlag=false
                             self.dailyViewFlag=false
                             self.weeklyScheduleFlag=false
                        }
                        
                    }) {
                         VStack{
                            Image(systemName: "list.dash").resizable()
                                .frame(maxWidth: 25,maxHeight: 25).foregroundColor((self.listFlag ?  self.choosenColor : self.defaultColor))
                            Text("Tasks").frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(self.listFlag ?  self.choosenColor : self.defaultColor)
                        }
                        }.background(Rectangle().fill(Color.white.opacity(0))).padding(.top,12)
                Divider().frame(maxHeight: 75)
                Button(action: {
                        withAnimation(.easeInOut(duration: 1)){
                             self.settingsFlag=true
                            
         
                             self.addTaskFlag=false
                             self.dailyViewFlag=false
                             self.weeklyScheduleFlag=false
                             self.listFlag=false
                        }
                    }) {
                            VStack{
                                  Image(systemName: "gear").resizable()
                                       .frame(maxWidth: 25,maxHeight: 25).foregroundColor((self.settingsFlag ?  self.choosenColor : self.defaultColor))
                                Text("Settings").frame(maxWidth: .infinity,maxHeight: 40).foregroundColor(self.settingsFlag ?  self.choosenColor : self.defaultColor)
                            }
                }.background(Rectangle().fill((Color.white.opacity(0)))).padding(.top,12)
             
                               
                    
                }
                

                   Divider()
                
                }.onAppear{  self.taskViewModel.retrieveAllTasks()
                    self.taskViewModel.retrieveAllTasksByHour()
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    
       
        }.background(    LinearGradient(
        gradient: Gradient(colors: [Color(hex:"#00d2ff"),Color(hex:"#3a7bd5")]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                 //self.color,.purple,.purple,.purple
                    startPoint: .bottomLeading,
                  endPoint:.bottomTrailing
                ))
        
        
    }
}

struct MainUI2_Previews: PreviewProvider {
    static var previews: some View {
        MainUI2()
    }
}
