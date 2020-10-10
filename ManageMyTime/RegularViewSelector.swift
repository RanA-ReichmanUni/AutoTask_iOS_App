//
//  RegularViewSelector.swift
//  ManageMyTime
//
//  Created by רן א on 30/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct RegularViewSelector: View {
    
    var hour:String
    var weekByHour:TasksPerHourPerDay
    
    var geometry:GeometryProxy
    
    
      @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
         VStack {
                   
          
            if(geometry.size.width <= 1024.0 && geometry.size.width > 990.5)//IPad Pro 12.9 inch
                {
                   
                
                    WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:8.5,heightFactor:10)
                    
                }
            if(geometry.size.width <= 990.5 && geometry.size.width > 808)//IPad Pro 12.9 inch on the side
                 {
                      
                    WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:8.5,heightFactor:10)
                                        
                 }
                else if(geometry.size.width <= 808 && geometry.size.width > 768)//IPhone 11,11 Pro, 11 Pro Max
                {
                     
                    WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:8.7,heightFactor:8)
                                                   
                }
                else if(geometry.size.width <= 768 && geometry.size.width > 736)//IPad 6th
                {
                     
                    WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:8.71,heightFactor:10)
                                                   
                }
                else if(geometry.size.width <= 736 && geometry.size.width > 703.5)//IPhone 8 Plus expanded
               {
                    
                WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:9.7,heightFactor:7)
                                                  
               }
                    
                else if(geometry.size.width <= 703.5 && geometry.size.width > 416) //IPad 6th on the side
                {
                           
                    //Text(geometry.size.width.description)
                    WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:9,heightFactor:8)
                                                              
                }
                else if(geometry.size.width <= 416)//IPhone 8 Plus on the side
               {
                    
                WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:11,heightFactor:5)
                                                  
               }
           
            
              

        }
    }
}
/*
struct RegularViewSelector_Previews: PreviewProvider {
    static var previews: some View {
        RegularViewSelector()
    }
}
*/
