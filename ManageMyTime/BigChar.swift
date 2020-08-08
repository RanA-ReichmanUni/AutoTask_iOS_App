//
//  BigChar.swift
//  ManageMyTime
//
//  Created by רן א on 04/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct BigChar: View {
    var hour:String
    var body: some View {
        HStack {
            if(Int(hour)==Date().hour)
            {
                Text(hour).background(RoundedRectangle(cornerRadius: 6).fill(Color.red)).foregroundColor(.white)
                
                 
                 Divider().padding(EdgeInsets(top: 5, leading: 1, bottom:0, trailing: 5))
            }
            else{
                Text(hour)
                               
                                
                Divider().padding(EdgeInsets(top: 5, leading: 1, bottom:0, trailing: 5))
            }
              }
    }
}
