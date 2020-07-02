//
//  DailyViewRow.swift
//  ManageMyTime
//
//  Created by רן א on 02/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DailyViewRow: View {
    
    let shapeColors : [Color]

    var names : [String]

    let orange = Color(red: 1, green: 165/255, blue: 0)
    let pink = Color(red: 200, green: 165/255, blue: 100)
    let blue = Color(red: 0, green: 100/255, blue: 200)
    let yellow = Color(red: 255, green: 255/255, blue:0)
    let white = Color(red: 255, green: 255/255, blue: 255)
    let black = Color(red: 0, green: 0/255, blue: 0)
    
    
    var body: some View {
        ScrollView(.horizontal){
            HStack
                {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 250, height: 100)
                            .foregroundColor(blue).padding()
                        ForEach(names, id: \.self){
                            item in
                        
                        Text(item).foregroundColor(.white)
                        }
                }
               
            }
        }
    }
}

struct DailyViewRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyViewRow()
    }
}
