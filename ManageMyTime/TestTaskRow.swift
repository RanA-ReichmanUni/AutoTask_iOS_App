//
//  TestTable.swift
//  ManageMyTime
//
//  Created by רן א on 02/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TestTaskRow: View {
    
    var taskName:String
    
   var heightFactor : CGFloat
    
    var offSet:Int
    
    var fillColor:Color
    
    
    var body: some View {
    GeometryReader { geometry in
            VStack(spacing: 0) {
                Text(self.taskName)
                    //geometry.size.width seems to be relatice to what ever exsits on the eidth axis, if it's empty, then it's all the screen width, if there something, then it's becomes relative
                    .frame(width: geometry.size.width, height: self.heightFactor * geometry.size.height)//rowHeight is as calculated above
                    .background(RoundedRectangle(cornerRadius: 5).fill(self.fillColor)).foregroundColor(.white)
                Spacer()
                
        }
        }
    }
}

struct TestTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(taskName:"Algebra",heightFactor: CGFloat(1.4),offSet:50,fillColor:Color(.systemPink))
    }
}
