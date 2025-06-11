//
//  BottomMainMenu.swift
//  ManageMyTime
//
//  Created by רן א on 23/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct BottomMainMenu: View {
    
    @Binding var settingsFlag:Bool
    @Binding var addTaskFlag:Bool
    @Binding var dailyViewFlag:Bool
    @Binding var weeklyScheduleFlag:Bool
    @Binding var listFlag:Bool
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
              HStack{
                  Spacer()
                  
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
                        withAnimation(.easeInOut(duration: 1.5)){
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
           
                Spacer()
                               
                    
              }
             Spacer()
            }.background(LinearGradient(
              gradient: Gradient(colors: [Color(hex:"#00d2ff"),Color(hex:"#3a7bd5")]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                           //self.color,.purple,.purple,.purple
                            startPoint: .topLeading,
                           endPoint:.bottomTrailing
                          ))
              
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

/*struct BottomMainMenu_Previews: PreviewProvider {
    static var previews: some View {
        BottomMainMenu()
    }
}
*/
