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

    
    var fillColor:Color
    
     @State var change: Bool = false
    
        
    
    var body: some View {
    GeometryReader { geometry in
        VStack() {
            Text(self.taskName).frame(width: geometry.size.width+10, height:  geometry.size.height)//.minimumScaleFactor(0.9)
                    //geometry.size.width seems to be relative to what ever exsits on the eidth axis, if it's empty, then it's all the screen width, if there something, then it's becomes relative
                    //rowHeight is as calculated above
                .background(RoundedRectangle(cornerRadius: 5).fill(self.fillColor)).foregroundColor(.white)
                    .modifier(AnimatingCellHeight(height: self.change ? 50 : geometry.size.height))
                               .foregroundColor(Color.red)
                               .onTapGesture {
                                   withAnimation {
                                       self.change.toggle()
                                   }
            }
                    
                Spacer()
            Spacer()
          
            
                
        }
        }
    }
}

struct TestTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(taskName:"Algebra",heightFactor: CGFloat(1.4),fillColor:Color(.systemPink))
    }
}


struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0

    var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }

    func body(content: Content) -> some View {
        content.frame(height: height)
    }
}
