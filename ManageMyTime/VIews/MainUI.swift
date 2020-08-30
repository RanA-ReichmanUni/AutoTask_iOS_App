//
//  MainUI.swift
//  ManageMyTime
//
//  Created by רן א on 20/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct MainUI: View {
    
    @State var settingsFlag=false
    @State var addTaskFlag=false
    @State var dailyViewFlag=false
    @State var weeklyScheduleFlag=false
    @State var listFlag=false
    
    @ObservedObject var taskViewModel = TaskViewModel()
    var body: some View {
    
        VStack{
  
            
            

            VStack{
                   
                     if(settingsFlag)
                     {
                        ButtonTestingView().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)
                     }
                     
                     else if (addTaskFlag)
                     {
                         AddTask().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)
                     }
                     else if(dailyViewFlag)
                     {
                        DailyView().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)
                                           
                        
                     }
                     else if(weeklyScheduleFlag)
                     {
                        ScheduleViewRow(taskViewModel:self.taskViewModel).transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)
                     }
                     else if(listFlag)
                     {
                         TaskList(taskViewModel:self.taskViewModel).transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)
                     }
                     else{
                           
                        Spacer()
                             Spacer()
                             Spacer()
                             Spacer()
                    }
            }.transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))
       Spacer()
            
            BottomMainMenu(settingsFlag: $settingsFlag, addTaskFlag: $addTaskFlag, dailyViewFlag: $dailyViewFlag, weeklyScheduleFlag: $weeklyScheduleFlag, listFlag: $listFlag).padding(.top,10).frame(height:20)
            
           /* HStack{
              
              
                Button(action: {
                    withAnimation(.easeInOut){
                        self.addTaskFlag=true
                        self.settingsFlag=false
                       
                        self.dailyViewFlag=false
                        self.weeklyScheduleFlag=false
                        self.listFlag=false
                    }
                }) {
                    Image(systemName: "wand.and.stars").resizable()
                        .frame(width: 25, height: 25).foregroundColor(self.addTaskFlag ?  Color.green : Color.white)
                }.background(Circle().frame(width:60,height:60).foregroundColor(Color.blue)).padding(20)
                
                //Circle().fill(Color.blue).frame(width:45)

             
              
                Button(action: {
                    withAnimation(.easeInOut){
                         self.weeklyScheduleFlag=true
                         self.settingsFlag=false
                         self.addTaskFlag=false
                         self.dailyViewFlag=false
                       
                         self.listFlag=false
                    }
                  
                }) {
                      Image(systemName: "calendar").resizable()
                      .frame(width: 25, height: 25).foregroundColor((self.weeklyScheduleFlag ?  Color.green : Color.white))
                    }.background(Circle().frame(width:60,height:60).foregroundColor(Color.blue)).padding(20)
                
                Button(action: {
                    withAnimation(.easeInOut){
                         self.dailyViewFlag=true
                         self.settingsFlag=false
                         self.addTaskFlag=false
            
                         self.weeklyScheduleFlag=false
                         self.listFlag=false
                    }
                }) {
                    Image(systemName: String(String(Date().day)+".square")).resizable()
                    .frame(width: 25, height: 25).foregroundColor((self.dailyViewFlag ?  Color.green : Color.white))
                 }.background(Circle().frame(width:60,height:60).foregroundColor(Color.blue)).padding(20)
                
                Button(action: {
                    withAnimation(.easeInOut){
                         self.listFlag=true
                         self.settingsFlag=false
                         self.addTaskFlag=false
                         self.dailyViewFlag=false
                         self.weeklyScheduleFlag=false
                    }
                    
                }) {
                    Image(systemName: "list.dash").resizable()
                        .frame(width: 25, height: 20).foregroundColor((self.listFlag ?  Color.green : Color.white))
                }.background(Circle().frame(width:60,height:60).foregroundColor(Color.blue)).padding(20)
                
                Button(action: {
                    withAnimation(.easeInOut){
                         self.settingsFlag=true
                        
     
                         self.addTaskFlag=false
                         self.dailyViewFlag=false
                         self.weeklyScheduleFlag=false
                         self.listFlag=false
                    }
                }) {
                          Image(systemName: "gear").resizable()
                              .frame(width: 30, height: 30).foregroundColor((self.settingsFlag ?  Color.green : Color.white))
                      }.background(Circle().frame(width:60,height:60).foregroundColor(Color.blue)).padding(20)
       
    
                           
                
            }
            */
            
            
            
            
            }.onAppear{  self.taskViewModel.retrieveAllTasks()}
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    
        
        
        
        
    }
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI()
    }
}
