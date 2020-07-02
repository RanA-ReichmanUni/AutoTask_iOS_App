//
//  TestTable.swift
//  ManageMyTime
//
//  Created by רן א on 02/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TestTaskRow: View {
    
   var heightFactor : CGFloat
    
    var body: some View {
    GeometryReader { geometry in
            VStack(spacing: 0) {
                Text("Algebra excersize 1")
                    .frame(width: geometry.size.width, height: self.heightFactor * geometry.size.height)//rowHeight is as calculated above
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.pink)).foregroundColor(.white)
                Spacer()
                
        }
        }
    }
}

struct TestTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(heightFactor: CGFloat(1.4))
    }
}
