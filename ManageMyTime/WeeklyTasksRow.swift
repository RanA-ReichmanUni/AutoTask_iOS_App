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
    
    var offSet:Int
    
    var body: some View {
         
   
                    HStack {
                        Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                        
                        ForEach(self.hourTasks, id:\.self){
                             taskName in
                        HStack {
                            TestTaskRow(taskName: taskName, heightFactor:     CGFloat(self.heightFactor),offSet:self.offSet).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))}

                    
                }
              }
    }
}

struct WeeklyTasksRow_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTasksRow(timeChar: "23" ,hourTasks: ["math","hello"], heightFactor: CGFloat(1.5),offSet:50)
    }
}
