//
//  ReceiptAssessor.swift
//  AutoTask
//
//  Created by רן א on 08/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
//import Purchases


struct ReceiptAssessor
{
    var taskViewModel:TaskViewModel
    
   
    
    func doIt(){
        
        
        
    }
    
    /*func TrailModeCheckSubscription()
    {
      var restoredSubscription=false
           
        var failedRestoringSubscription=false
        
        DispatchQueue.global(qos: .utility).async {
            
            Purchases.shared.restoreTransactions { (purchaserInfo, error) in
                if purchaserInfo?.entitlements["Full Access"]?.isActive == true {
                   // Unlock that great "pro" content
                    self.taskViewModel.hasFullAccess=true
                    UserDefaults.standard.set(true, forKey: "nonSuspicious")
                    UserDefaults.standard.set(true, forKey: "hasBeenSubscribed")
                    UserDefaults.standard.set(0,forKey: "offlineClicks")
                    self.taskViewModel.SetEndTrail()
                    
                    restoredSubscription=true
                    
                    
                 }
                else if purchaserInfo?.entitlements["Full Access"]?.isActive == false{
                    self.taskViewModel.setEndSubscription()
                    failedRestoringSubscription=true
                }
                
                if (purchaserInfo == nil){
               
                    
                    
                    let numberOfClicks=UserDefaults.standard.integer(forKey: "offlineClicks")
                    UserDefaults.standard.set(numberOfClicks+1,forKey: "offlineClicks")
                    
                    if(numberOfClicks+1 >= 30)
                    {
                        self.taskViewModel.hasFullAccess=false
                        UserDefaults.standard.set(false, forKey: "nonSuspicious")
                        
                    }
                    
                     failedRestoringSubscription=true
                    
                }
            }
            
        }
       
        DispatchQueue.main.async {
            
            if(restoredSubscription==true)
            {
                self.taskViewModel.restoredSubscription=true
            }
            if(failedRestoringSubscription==true)
            {
                self.taskViewModel.restoredSubscription=false
                self.taskViewModel.setEndSubscription()
            }
        }
        
        
    }*/
    
    
}
