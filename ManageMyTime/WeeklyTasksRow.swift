//
//  WeeklyTasksRow.swift
//  ManageMyTime
//
//  Created by רן א on 03/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct WeeklyTasksRow: View {
    
    var timeChar : String

    var hourTasks : [String]
    
    var heightFactor : CGFloat
    
    
    var body: some View {
         
   
                    HStack {
                        Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                        
                        ForEach(self.hourTasks, id:\.self){
                             task in
                    
                            TestTaskRow(heightFactor:     CGFloat(self.heightFactor)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))

                    
                }
              }
    }
}

struct WeeklyTasksRow_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTasksRow(timeChar: "23" ,hourTasks: ["math","hello"], heightFactor: CGFloat(1.5))
    }
}
