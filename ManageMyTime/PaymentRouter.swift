//
//  PaymentRouter.swift
//  ManageMyTime
//
//  Created by רן א on 05/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PaymentRouter: View {
    @ObservedObject var taskViewModel:TaskViewModel
    var receiptAssessor:ReceiptAssessor
    var body: some View {
        VStack{
            if(!self.taskViewModel.trailEnded || UserDefaults.standard.bool(forKey: "nonSuspicious") || self.taskViewModel.hasFullAccess)
            {
                MainViewRouter(taskViewModel:self.taskViewModel).environmentObject(ViewRouter())
            }
            else
            {
                PayWall(taskViewModel:self.taskViewModel,receiptAssessor:receiptAssessor)
            }
        }.onAppear{//self.taskViewModel.CheckSubscription()
                  //  self.taskViewModel.getPurchaserInfo()
            //self.taskViewModel.TrailModeCheckSubscription()
                   self.taskViewModel.UpdateTrailEndStatus()
                  
        }
    }
}

/*struct PaymentRouter_Previews: PreviewProvider {
    static var previews: some View {
        PaymentRouter()
    }
}
*/
