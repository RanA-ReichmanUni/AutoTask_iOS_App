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
          
                MainViewRouter(taskViewModel:self.taskViewModel).environmentObject(ViewRouter())
          
        }.onAppear{//self.taskViewModel.CheckSubscription()
                    //self.taskViewModel.getPurchaserInfo()
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
