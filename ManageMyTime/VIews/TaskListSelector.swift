//
//  TaskListSelector.swift
//  ManageMyTime
//
//  Created by רן א on 29/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TaskListSelector: View {
    
    var taskViewModel:TaskViewModel
    @State var dayIndexSelector:Int=0
    var geometry:GeometryProxy
    @Binding var addTaskFlag:Bool
    @Binding var listFlag:Bool
    var body: some View {
        
        VStack{
            if(taskViewModel.GetAnimationStyleSettings()==animationStyle.smooth.rawValue)
            {
                TaskList(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.DayToIndexConverter(),geometry:geometry,addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag)
                
            }
            else if(taskViewModel.GetAnimationStyleSettings()==animationStyle.fast.rawValue)
            {
                TaskListFastAnimation(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.DayToIndexConverter(),geometry:geometry,addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag)
            }
            else if(taskViewModel.GetAnimationStyleSettings()==animationStyle.spring.rawValue)
            {
                TaskListSpringAnimation(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.DayToIndexConverter(),geometry:geometry,addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag)
            }
            else{
                TaskList(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.DayToIndexConverter(),geometry:geometry,addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag)
            }
        }
    }
}

/*struct TaskListSelector_Previews: PreviewProvider {
    static var previews: some View {
        TaskListSelector()
    }
}
*/
