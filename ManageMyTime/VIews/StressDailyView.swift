//
//  StressDailyView.swift
//  ManageMyTime
//
//  Created by רן א on 02/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct StressDailyView: View {

    var taskModel = TaskModel()
    var body: some View {
        
        List(taskModel.getAllDailyLoads(), id: \.self)
            { dailyLoad in
            
            VStack{
                
                
                HStack{
                    
                    Text("Date: ")
                    Text(String(dailyLoad.date.day))
                    Text(":")
                    Text(String(dailyLoad.date.month))
                    Text(":")
                    Text(String(dailyLoad.date.year))
                    
                    
                }

                    Text("Stress: ")
                    Text(dailyLoad.loadLevel.description)
                
                    CircularBar(percentage:dailyLoad.loadLevel)
            }
            
            
        }
    }
}

/*struct StressDailyView_Previews: PreviewProvider {
    static var previews: some View {
        StressDailyView()
    }
}*/
