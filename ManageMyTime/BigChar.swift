//
//  BigChar.swift
//  ManageMyTime
//
//  Created by רן א on 04/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct BigChar: View {
    var hour:Int
    var body: some View {
        HStack {
            if(hour==Date().hour)
            {
                Text(String(hour)).background(RoundedRectangle(cornerRadius: 6).fill(Color.red)).foregroundColor(.white)
                
                 
                 Divider().padding(EdgeInsets(top: 5, leading: -1, bottom:0, trailing: 1))
            }
            else{
                Text(String(hour))
                               
                                
                Divider().padding(EdgeInsets(top: 5, leading: -1, bottom:0, trailing: 1))
            }
              }
    }
}
