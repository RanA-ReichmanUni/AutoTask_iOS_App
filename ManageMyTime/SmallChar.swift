//
//  SmallChar.swift
//  ManageMyTime
//
//  Created by רן א on 05/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct SmallChar: View {
    var hour:Int
    var body: some View {
            HStack {
                            Text(String(0)).padding(EdgeInsets(top: 5, leading: -1, bottom:0, trailing: 0))
                            
                            Text(String(hour)).padding(EdgeInsets(top: 5, leading: -8, bottom:0, trailing:0))
                         
                            Divider().padding(EdgeInsets(top: 5, leading: -2, bottom:0, trailing: 40))
                        }
    }
}

struct SmallChar_Previews: PreviewProvider {
    static var previews: some View {
        SmallChar(hour:9)
    }
}
