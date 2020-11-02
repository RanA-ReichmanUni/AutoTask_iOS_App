//
//  SettingsUI.swift
//  ManageMyTime
//
//  Created by רן א on 11/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct SettingsUI: View {
    
    @ObservedObject var restrictedSpaceViewModel=RestrictedSpaceViewModel()
    var densityValues = ["Very Spacious", "Spacious", "Medium Density", "Dense","Very Dense","Extremly Dense","Maximum Capacity"]
    var schedulingAlgorithm = ["Smart - Least work stress (based on difficulty and work time in combine)","Optimal - Least work time per day.","Advanced - Least work time per day, exclude personal activities.","Earliest","Latest - Near due"]
    var breakPeriods = ["45 Minutes Work Scections, 5 Minutes Breaks","Classic - 1:30 Hour Work Sections, At Least 20 Minutes Breaks","2 Hours Work Sections, At Least 30 Minutes Breaks","3 Hours Work Sections, At Least 1 Hour Breaks","5 Hours Sections, At Least 1:30 Hour Breaks"/*,"Continues - No Breaks" disabled for know !!!!*/]
    var animationsValues = ["Smooth","Fast","Spring"]
    @State var selectedDensityIndex = 2
    @State var selectedSchedulingAlgorithmIndex = 0
    @State var selectedBreakPeriodsIndex = 1
    @State var selectedAnimationIndex = 0
    
    @Environment(\.colorScheme) var colorScheme
    var taskViewModel:TaskViewModel
  
   // var restrictedSpaceViewModel=RestrictedSpaceViewModel()
    @State var showAlert=false
    
    @Binding var addTaskFlag:Bool
    @Binding var listFlag:Bool
    
   @State var fromSelection: [String] = [7, 0, 0].map { "\($0)" }
   @State var toSelection: [String] = [22, 0, 0].map { "\($0)" }
    @State var alertType=1
    
    private func SetSettings() {
           
        self.taskViewModel.SetSettingsValues(scheduleAlgorithimIndex: selectedSchedulingAlgorithmIndex, scheduleDensityIndex: selectedDensityIndex,breakPeriodsIndex: selectedBreakPeriodsIndex,animationStyleIndex: selectedAnimationIndex)
        self.showAlert=true
        self.alertType=1
          
         }
    
     private func SetSettingsAnimation() {
        
            self.taskViewModel.SetSettingsValues(scheduleAlgorithimIndex: selectedSchedulingAlgorithmIndex, scheduleDensityIndex: selectedDensityIndex,breakPeriodsIndex: selectedBreakPeriodsIndex,animationStyleIndex: selectedAnimationIndex)
        
    }
    
   
    
    
    
    var body: some View {
        UITableView.appearance().backgroundColor = self.colorScheme == .dark ? Color.black.uiColor() : Color(hex:"#fcfcfc").uiColor()
            return  NavigationView {
             
         
  Form{
                
                                       
                                     
                        NavigationLink(destination:RestrictedSpaceUI(restrictedSpaceViewModel:self.restrictedSpaceViewModel)){
                            HStack{
                                
                                
                                           Text("View And Manage Your Repeated Activities")
                                            Spacer()
                                          }
                                       }
    
                    NavigationLink(destination:DayBoundsView(taskViewModel: self.taskViewModel,fromSelection: self.$fromSelection,toSelection:self.$toSelection,showAlert:self.$showAlert,alertType:self.$alertType)){
                              HStack{
                                  
                                  
                                     Text("Set Day Bounds For Auto Scheduling")
                                      Spacer()
                                    }
                                 }
      
                            
    /*NavigationLink(destination:AddRestrictedSpaceUI(taskViewModel: self.taskViewModel, listFlag: self.$listFlag, addTaskFlag: self.$addTaskFlag)){
                                HStack{
                                    Text("Add Personal Occupied Space")
                                    Spacer()
                                }
                            }*/
                           
          
                         //Using Binding extention
                       /*    Picker(selection: self.$selectedDensityIndex.onUpdate(SetSettings), label: Text("Daily Schedule Density")) {
                               ForEach(0 ..< self.densityValues.count) {
                                     Text(self.densityValues[$0])
                                   }
                           }*/
                        
                                    
                                 //Using Binding extention
                                   Picker(selection: self.$selectedSchedulingAlgorithmIndex.onUpdate(SetSettings), label: Text("Schedule Algorithm")) {
                                    ForEach(0 ..< self.schedulingAlgorithm.count, id: \.self) {
  
                                                Text(self.schedulingAlgorithm[$0]).padding(.leading,10)

                                           }
                                   }
                            
                                 
                    
                                 //Using Binding extention
                                Picker(selection: self.$selectedBreakPeriodsIndex.onUpdate(SetSettings), label: Text("Break Periods")) {
                                       ForEach(0 ..< self.breakPeriods.count, id: \.self) {
                                             Text(self.breakPeriods[$0]).padding(.leading,50)
                                           }
                                   }
                                    
                                    
                              
    
                                
                                 
                         
                                

                            Picker(selection: self.$selectedAnimationIndex.onUpdate(SetSettingsAnimation), label: Text("Main View Animation")) {
                                ForEach(0 ..< self.animationsValues.count, id: \.self) {
                                      Text(self.animationsValues[$0])
                                    }
                            }
                                        
                        HStack{
                            
                            Button(action: { try? self.taskViewModel.autoFillTesting()
                                       self.taskViewModel.retrieveAllTasks()
                                   }) {
                                           Text("Click to Auto Fill")
                                           }
                        }
    
                        HStack{
                            
                            Button(action: { self.taskViewModel.DestroyAll()
                                       self.taskViewModel.retrieveAllTasks()
                                   }) {
                                           Text("Destroy All !")
                                           }
                        }
    
    
                        HStack{
                              
                              Button(action: { self.taskViewModel.feedAllFreeSpacesTest()
                                         self.taskViewModel.retrieveAllTasks()
                                     }) {
                                             Text("Feed Free Spaces To Merge")
                                             }
                          }
    
    
                        
                       /* HStack{
                                          
                            Button(action: { self.restrictedSpaceViewModel.getAllRestrictedSpace()
                                     }) {
                                             Text("Click to Check restricted Spacees")
                                             }
                          }*/
                        
                        
                        
                        
                        
                        
                    
  }.navigationBarTitle(Text("Settings"),displayMode: .inline)
        
                }.alert(isPresented: self.$showAlert) {
         
            switch self.alertType{
                case 1:
                    return Alert(title: Text("Updated Successfully !"),
                                 message: Text("\nChanges Will Take Effect With Future Assignments."),
                                 dismissButton: .default(Text("OK")))
                case 2:
                    return Alert(title: Text("Updated Successfully !"),
                                     message: Text("\nIn Order To Not Effect Your Current Schedule, The Changes Will Take Effect With Future Scheduled Dates."),
                                     dismissButton: .default(Text("OK")))
                default:
                    return Alert(title: Text("Updated Successfully !"),
                                     message: Text("\nThe Changes Will Take Effect With Future Assignments."),
                                     dismissButton: .default(Text("OK")))
            }
          
     
                     

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

/*struct SettingsUI_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUI()
    }
}*/

extension Color {

    func uiColor() -> UIColor {

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}


extension Binding {
    

    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            self.wrappedValue
        }, set: { newValue in
            self.wrappedValue = newValue
            closure()
        })
    }
}
