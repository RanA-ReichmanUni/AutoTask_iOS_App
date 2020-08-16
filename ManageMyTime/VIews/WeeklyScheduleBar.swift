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
                                      Text("Sun").foregroundColor(Color.blue).frame(width: geometry.size.width/5, height:  geometry.size.height)
                                           
                                    Text("Mon").foregroundColor(Color.red).frame(width: geometry.size.width/2.04, height:  geometry.size.height)
                                      Text("Tue").foregroundColor(Color.blue).frame(width: geometry.size.width/1.319, height:  geometry.size.height)
                                      Text("Wen").foregroundColor(Color.red).frame(width: geometry.size.width/0.95, height:  geometry.size.height)
                                      Text("Tue").foregroundColor(Color.blue).frame(width: geometry.size.width/0.74, height:  geometry.size.height)
                                      Text("Fri").foregroundColor(Color.red).frame(width: geometry.size.width/0.61, height:  geometry.size.height)
                                      Text("Sat").foregroundColor(Color.blue).frame(width: geometry.size.width/0.52, height:  geometry.size.height)
                                  }
            }.frame(height: 30).padding().background((LinearGradient(
                gradient: Gradient(colors: [Color(hex:"#59C173"),Color(hex:"#a17fe0"),Color(hex:"#5D26C1"),Color.white]),
                startPoint: .leading,
                endPoint:.bottom
            )))//was 30 in height
    }
}

struct WeeklyScheduleBar_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScheduleBar()
    }
}
