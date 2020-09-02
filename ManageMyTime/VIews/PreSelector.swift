//
//  PreSelector.swift
//  ManageMyTime
//
//  Created by רן א on 30/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PreSelector: View {
    
    var hour:String
    var weekByHour:TasksPerHourPerDayOfTheWeek
     
    var geometry:GeometryProxy
    
    var body: some View {
        HStack{
            if(weekByHour.hour==Int(hour) ?? 0)
            {
                ForEach(weekByHour.tasks)
                { weekly in
                    Spacer()
                   // ScehduleSelector(hour:String(self.hour),weekByHour: weekly,geometry:self.geometry).listRowBackground(Color.green)
                }
            }
        }
    }
}

/*struct PreSelector_Previews: PreviewProvider {
    static var previews: some View {
        PreSelector()
    }
}*/
