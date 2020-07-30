//
//  ScehduleSelector.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct ScehduleSelector: View {
    
    var hour:String
    var weekByHour:TasksPerHourPerDay
    
    var geometry:GeometryProxy

    
      @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    
    var body: some View {
       VStack {
               
            if self.horizontalSizeClass == .compact {
                                 
               CompactViewSelector(hour:String(hour),weekByHour: weekByHour,geometry:self.geometry)

                                                
               } else if self.horizontalSizeClass == .regular{
                        
                    RegularViewSelector(hour:String(hour),weekByHour: weekByHour,geometry:self.geometry)
                       
               }
           }
       
    }
}

/*struct ScehduleSelector_Previews: PreviewProvider {
    static var previews: some View {
        ScehduleSelector()
    }
}
*/
