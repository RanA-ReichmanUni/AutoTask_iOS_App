//
//  HourlyTime.swift
//  ManageMyTime
//
//  Created by רן א on 07/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import UIKit



class HourlyTime {
    
    var hour = 0
    var minutes = 0
    
    
    func add(hour: Int, minutes: Int)
    {
        guard hour>=0 && minutes>=0 else {
            return
        }
        
        if(self.minutes+minutes>60)
        {
            self.minutes=self.minutes+minutes-60
            self.hour+=1
            
        }
    
        else{
            
        self.minutes=self.minutes+minutes
        
        }
        
        self.hour=self.hour+hour
        
    }
    

    
}
