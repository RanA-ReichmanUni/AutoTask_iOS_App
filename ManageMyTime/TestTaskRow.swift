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
    
    var body: some View {
    GeometryReader { geometry in
            VStack(spacing: 0) {
                Text(self.taskName)
                    .frame(width: geometry.size.width/8, height: self.heightFactor * geometry.size.height)//rowHeight is as calculated above
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.pink)).foregroundColor(.white).offset(x: CGFloat(self.offSet))
                Spacer()
                
        }
        }
    }
}

struct TestTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(taskName:"Algebra",heightFactor: CGFloat(1.4),offSet:50)
    }
}
