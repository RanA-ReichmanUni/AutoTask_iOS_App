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
    var body: some View {
        
        VStack{
            if(taskViewModel.GetAnimationStyleSettings()==animationStyle.smooth.rawValue)
            {
                TaskList(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.latestDayChoiseIndex,geometry:geometry)
                
            }
            else if(taskViewModel.GetAnimationStyleSettings()==animationStyle.fast.rawValue)
            {
                TaskListFastAnimation(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.latestDayChoiseIndex,geometry:geometry)
            }
            else if(taskViewModel.GetAnimationStyleSettings()==animationStyle.spring.rawValue)
            {
                TaskListSpringAnimation(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.latestDayChoiseIndex,geometry:geometry)
            }
            else{
                TaskList(taskViewModel:self.taskViewModel,dayIndexSelector: self.taskViewModel.latestDayChoiseIndex,geometry:geometry)
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
