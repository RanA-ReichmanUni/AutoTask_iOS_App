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
    var densityValues = ["Very Spacious", "Spacious", "Medium Density", "Dense","Very Dense","Maximum Capacity"]
    var schedulingAlgorithm = ["Smart \n(Least load per day)","Optimal \n(Least load per day, exclude personal activities)","Earliest","Latest (near due)"]
    @State private var selectedDensityIndex = 2
    @State private var selectedSchedulingAlgorithmIndex = 0
    @Environment(\.colorScheme) var colorScheme
    var taskViewModel:TaskViewModel
    
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
                                  
                                    Picker(selection: self.$selectedDensityIndex, label: Text("Daily Schedule Density")) {
                                        ForEach(0 ..< self.densityValues.count) {
                                                                          Text(self.densityValues[$0])
                                                                        }
                                    }
                                 
                                }
                                    
                            }
                                    
                                 
                            
                                 
                                
                            
                            NavigationLink(destination:AddRestrictedSpace()){
                                   HStack{
                                       Text("Scheduling Break Periods")
                                       Spacer()
                                   }
                                
                         }
                            

                            HStack{
                                 Picker(selection: self.$selectedSchedulingAlgorithmIndex, label: Text("Schedule Algorithm")) {
                                            ForEach(0 ..< self.schedulingAlgorithm.count) {
                                                     Text(self.schedulingAlgorithm[$0])
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
        
        }/*.background(
            self.colorScheme == .dark ? ( LinearGradient(
                gradient: Gradient(colors: [Color("#f1f1f1"),Color("#d1d1d1"),Color("#ffffff"),Color.blue]),
                         startPoint: UnitPoint(x: 0.2, y: 0.4),
                         endPoint:.bottom
                       )) :(
            LinearGradient(
            gradient: Gradient(colors: [Color.white,Color.blue]),
          startPoint: UnitPoint(x: 0.2, y: 0.4),
          endPoint:.bottom
        )))*/.onAppear{self.restrictedSpaceViewModel.getAllRestrictedSpace()}
        
        
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
