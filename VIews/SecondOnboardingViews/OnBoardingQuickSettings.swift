//
//  OnBoardingQuickSettings.swift
//  ManageMyTime
//
//  Created by רן א on 11/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct OnBoardingQuickSettings: View {
    
    @ObservedObject var restrictedSpaceViewModel=RestrictedSpaceViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var schedulingAlgorithm = ["Smart - Least work stress (based on difficulty and work time in combine)","Optimal - Least work time per day.","Advanced - Least work time per day, exclude personal activities.","Earliest","Latest - Near due"]
    var breakPeriods = ["45 Minutes Work Scections, 5 Minutes Break","Classic - 1:30 Hour Work Sections, 20 Minutes Break","2 Hours Work Sections, 30 Minutes Break","3 Hours Work Sections, 1 Hour Break","5 Hours Sections, 1:30 Hour Break"/*,"Continues - No Breaks" disabled for know !!!!*/]

    @State var selectedDensityIndex = 2
    @State var selectedSchedulingAlgorithmIndex = 0
    @State var selectedBreakPeriodsIndex = 1
    @State var selectedAnimationIndex = 0
    
    @Environment(\.colorScheme) var colorScheme
    var taskViewModel:TaskViewModel
  
   // var restrictedSpaceViewModel=RestrictedSpaceViewModel()
  

    
   @State var fromSelection: [String] = [7, 0, 0].map { "\($0)" }
   @State var toSelection: [String] = [22, 0, 0].map { "\($0)" }
    @State var alertType=1
    @State var showAlert=false
    @State var presentAlert=true
    
    private func SetSettings() {
           
        self.taskViewModel.SetSettingsValues(scheduleAlgorithimIndex: selectedSchedulingAlgorithmIndex, scheduleDensityIndex: selectedDensityIndex,breakPeriodsIndex: selectedBreakPeriodsIndex,animationStyleIndex: selectedAnimationIndex)
  
          
         }
    
    
   
    
    
    
    var body: some View {
        UITableView.appearance().backgroundColor = self.colorScheme == .dark ? Color.black.uiColor() : Color(hex:"#fcfcfc").uiColor()
            return  NavigationView {
                VStack{
  Form{
                
                                       
                   
    
                    NavigationLink(destination:DayBoundsView(taskViewModel: self.taskViewModel,fromSelection: self.$fromSelection,toSelection:self.$toSelection,showAlert:self.$showAlert,alertType:self.$alertType)){
                              HStack{
                                  
                                  
                                     Text("Day Start And End Bounds")
                                      Spacer()
                                    }
                                 }
  
                                   Picker(selection: self.$selectedSchedulingAlgorithmIndex.onUpdate(SetSettings), label: Text("Schedule Algorithm")) {
                                       ForEach(0 ..< self.schedulingAlgorithm.count) {
                                             Text(self.schedulingAlgorithm[$0])
                                           }
                                   }
                            
                                 
                    
                                 //Using Binding extention
                                Picker(selection: self.$selectedBreakPeriodsIndex.onUpdate(SetSettings), label: Text("Break Periods")) {
                                       ForEach(0 ..< self.breakPeriods.count) {
                                             Text(self.breakPeriods[$0])
                                           }
                                   }
                                    
                                    
                              
    
                                
                                 
                         
                                

    
    
                        
                       /* HStack{
                                          
                            Button(action: { self.restrictedSpaceViewModel.getAllRestrictedSpace()
                                     }) {
                                             Text("Click to Check restricted Spacees")
                                             }
                          }*/
                        
                        
                        
                        
                        
                        
                    
  }
                Button(action:{
                    
                    self.mode.wrappedValue.dismiss()
                })
                {
                    Text(" Finish ").frame(width:100,height:55).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color.blue).frame(width:100,height:55)).padding(.bottom,20)
                }
                }
        
        }.alert(isPresented: self.$presentAlert) {

                       Alert(title: Text("Please Update Your Personal preferences"),
                             message: Text("\n It's Importent To Take The Time And Determine You Personal preferences. \n\nAny Future Changes to The 'Break Periods' field And 'Day Start And End Bounds' field, Will Only Take Effect In Future Unscheduled Dates"),
                             dismissButton: .default(Text("OK")))

               
            }
                .navigationViewStyle(StackNavigationViewStyle())//Forces all devices (intended for iPads which have a diffrent navigationView style) navigationView to act like on an iPhone.
                
                
                /*.background(
            self.colorScheme == .dark ? ( LinearGradient(
                gradient: Gradient(colors: [Color("#f1f1f1"),Color("#d1d1d1"),Color("#ffffff"),Color.blue]),
                         startPoint: UnitPoint(x: 0.2, y: 0.4),
                         endPoint:.bottom
                       )) :(
            LinearGradient(
            gradient: Gradient(colors: [Color.white,Color.blue]),
          startPoint: UnitPoint(x: 0.2, y: 0.4),
          endPoint:.bottom
        )))*/.onAppear{self.restrictedSpaceViewModel.getAllRestrictedSpace()
            
            let settingsObject=self.taskViewModel.getSettingsValues()
            self.selectedDensityIndex=settingsObject[0]
            self.selectedSchedulingAlgorithmIndex=settingsObject[1]
            self.selectedBreakPeriodsIndex=settingsObject[2]
            self.selectedAnimationIndex=settingsObject[3]
            
            let dayBoundsSettings = self.taskViewModel.GetDayBoundsSettingsValues()
            
            self.fromSelection=[dayBoundsSettings[0],dayBoundsSettings[1]]
            self.toSelection=[dayBoundsSettings[2],dayBoundsSettings[3]]
            
        }
        
        
    }
    
  
}

/*struct OnBoardingQuickSettings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUI()
    }
}*/


