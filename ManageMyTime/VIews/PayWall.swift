//
//  PayWall.swift
//  ManageMyTime
//
//  Created by רן א on 04/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PayWall: View {
    @ObservedObject var taskViewModel:TaskViewModel
    var body: some View {
        
        ForEach(self.taskViewModel.SubscriptionTitles, id: \.self) { subscription in
            Button(action:{})
            {
                
                Text(subscription).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 25).fill(Color.blue).frame(width:400,height:100))
                
            }
        }
    }
}

/*struct PayWall_Previews: PreviewProvider {
    static var previews: some View {
        PayWall()
    }
}*/
