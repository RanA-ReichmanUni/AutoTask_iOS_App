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
    var schedulingAlgorithm = ["Smart - Least work stress, based on task difficulty and work time in combine.","Optimal - Least work time per day.","Advanced - Least work time per day, exclude personal activities.","Earliest","Latest - Near due"]
    var breakPeriods = ["45 Minutes Work Scections, 5 Minutes Break","Classic 1:30 Hour Work Sections, 20 Minutes Break","2 Hours Work Sections, 30 Minutes Break","3 Hours Work Sections, 1 Hour Break","5 Hours Sections, 1:30 Hour Break","Continues With No Breaks"]
    @State var selectedDensityIndex = 2
    @State var selectedSchedulingAlgorithmIndex = 0
    @Environment(\.colorScheme) var colorScheme
    var taskViewModel:TaskViewModel
    
    private func SetSettings() {
           
        taskViewModel.setSettingsValues(scheduleAlgorithimIndex: selectedSchedulingAlgorithmIndex, scheduleDensityIndex: selectedDensityIndex)
          
         }
    
    var body: some View {
        UITableView.appearance().backgroundColor = Color(hex:"#fcfcfc").uiColor()
            return  NavigationView {
           
  Form{
                
                                       
                                     
                        NavigationLink(destination:RestrictedSpaceUI(restrictedSpaceViewModel:self.restrictedSpaceViewModel)){
                            HStack{
                                
                                
                                           Text("Personal Activity Space")
                                            Spacer()
                                          }
                                       }
                            
                            NavigationLink(destination:AddRestrictedSpace()){
                                HStack{
                                    Text("Add Personal Occupied Space")
                                    Spacer()
                                }
                            }
                           
                                 
                            
                            VStack{
                                  
                                HStack{
                                  //Using Binding extention
                                    Picker(selection: self.$selectedDensityIndex.onUpdate(SetSettings), label: Text("Daily Schedule Density")) {
                                        ForEach(0 ..< self.densityValues.count) {
                                              Text(self.densityValues[$0])
                                            }
                                    }
                                 
                                }
                                    
                            }
                                    
                                 
                            
                                 
                                
                            
                          VStack{
                                                 
                                   HStack{
                                     //Using Binding extention
                                       Picker(selection: self.$selectedSchedulingAlgorithmIndex.onUpdate(SetSettings), label: Text("Schedule Algorithm")) {
                                           ForEach(0 ..< self.schedulingAlgorithm.count) {
                                                 Text(self.schedulingAlgorithm[$0])
                                               }
                                       }
                                    
                                   }
                                       
                               }
                                             
    
    
    
                        VStack{
                                  
                                HStack{
                                  //Using Binding extention
                                    Picker(selection: self.$selectedSchedulingAlgorithmIndex.onUpdate(SetSettings), label: Text("Schedule Algorithm")) {
                                        ForEach(0 ..< self.schedulingAlgorithm.count) {
                                              Text(self.schedulingAlgorithm[$0])
                                            }
                                    }
                                 
                                }
                                    
                            }
                                

    
                                        
                        HStack{
                            
                            Button(action: { try? self.taskViewModel.autoFillTesting()
                                       self.taskViewModel.retrieveAllTasks()
                                   }) {
                                           Text("Click to Auto Fill")
                                           }
                        }
    
    
                        
                        
                        
                        
                        
                        
                    
  }
        
        }.navigationViewStyle(StackNavigationViewStyle())//Forces all devices (intended for iPads which have a diffrent navigationView style) navigationView to act like on an iPhone.
                
                
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
            
            self.selectedDensityIndex=self.taskViewModel.getSettingsValues()[0]
            self.selectedSchedulingAlgorithmIndex=self.taskViewModel.getSettingsValues()[1]
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
