//
//  DviderTest.swift
//  ManageMyTime
//
//  Created by רן א on 14/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DviderTest: View {
    var offSet: Int
    var body: some View {
         Divider().offset(x: CGFloat(self.offSet))
    }
}

struct DviderTest_Previews: PreviewProvider {
    static var previews: some View {
        DviderTest(offSet:5)
    }
}
