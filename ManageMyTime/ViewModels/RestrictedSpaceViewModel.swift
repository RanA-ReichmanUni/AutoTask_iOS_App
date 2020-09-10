//
//  RestrictedSpaceViewModel.swift
//  ManageMyTime
//
//  Created by רן א on 19/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftUI


class RestrictedSpaceViewModel : ObservableObject
{
    var restrictedSpaceModel = RestrictedSpaceModel()
    
    @Published var allRestrictedSpaces = [RestrictedSpace]()
    
    
    func getAllRestrictedSpace ()
    {
        self.allRestrictedSpaces = restrictedSpaceModel.getAllRestrictedSpace()
    }
    
    func getRandomColor() -> Color
    {
        
        let colorArray = [Color.green,Color.pink,Color.red,Color.orange,Color.blue,Color(UIColor.systemTeal)].shuffled()
            
        return colorArray[0]
        
    }
    
    func CreateRestrictedSpace(startTimeHour:String,startTimeMinutes:String,endTimeHour:String,endTimeMinutes:String,dayOfTheWeek:String) throws
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
               
              
               let managedContext = appDelegate.persistentContainer.viewContext
        
        let startTime=Hour(context: managedContext)
        startTime.hour=Int(startTimeHour) ?? 0
        startTime.minutes=Int(startTimeMinutes) ?? 0
        
        let endTime=Hour(context: managedContext)
        endTime.hour=Int(endTimeHour) ?? 0
        endTime.minutes=Int(endTimeMinutes) ?? 0
        
        do{
           try restrictedSpaceModel.CreateRestrictedSpace(startTime: startTime, endTime: endTime, dayOfTheWeek: dayOfTheWeek)
        }
        catch RestrictedSpaceError.alreadyScheduled {
            throw RestrictedSpaceError.alreadyScheduled
        }
        catch{
            
        }
        
    }
    
    
}

