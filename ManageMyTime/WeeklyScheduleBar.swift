//
//  WeeklyScheduleBar.swift
//  ManageMyTime
//
//  Created by רן א on 03/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct WeeklyScheduleBar: View {
    var body: some View {
         HStack(alignment: .top){
                                  Image(systemName: "clock").padding(EdgeInsets(top: 9, leading: 5, bottom: 0, trailing: -6)).foregroundColor(.red)
                                  GeometryReader{geometry in
                                      Text("S").foregroundColor(Color.blue).frame(width: geometry.size.width/5, height:  geometry.size.height)
                                           
                                    Text("M").foregroundColor(Color.red).frame(width: geometry.size.width/2.09, height:  geometry.size.height)
                                      Text("T").foregroundColor(Color.blue).frame(width: geometry.size.width/1.32, height:  geometry.size.height)
                                      Text("W").foregroundColor(Color.red).frame(width: geometry.size.width/0.94, height:  geometry.size.height)
                                      Text("T").foregroundColor(Color.blue).frame(width: geometry.size.width/0.74, height:  geometry.size.height)
                                      Text("F").foregroundColor(Color.red).frame(width: geometry.size.width/0.605, height:  geometry.size.height)
                                      Text("S").foregroundColor(Color.blue).frame(width: geometry.size.width/0.518, height:  geometry.size.height)
                                  }
            }.frame(height: 30).padding()//was 30 in height
    }
}

struct WeeklyScheduleBar_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScheduleBar()
    }
}
