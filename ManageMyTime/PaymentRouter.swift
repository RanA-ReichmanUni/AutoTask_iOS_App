//
//  PaymentRouter.swift
//  ManageMyTime
//
//  Created by רן א on 05/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PaymentRouter: View {
    @ObservedObject var taskViewModel=TaskViewModel()
    
    var body: some View {
        VStack{
            if(!taskViewModel.trailEnded || UserDefaults.standard.bool(forKey: "nonSuspicious") || self.taskViewModel.hasFullAccess)
            {
                MainViewRouter(taskViewModel:self.taskViewModel).environmentObject(ViewRouter())
            }
            else
            {
                PayWall(taskViewModel:self.taskViewModel)
            }
        }.onAppear{self.taskViewModel.CheckSubscription()
                   self.taskViewModel.UpdateTrailEndStatus()
        }
    }
}

struct PaymentRouter_Previews: PreviewProvider {
    static var previews: some View {
        PaymentRouter()
    }
}
