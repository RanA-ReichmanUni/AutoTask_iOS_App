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
    

    
    func DayStringToNumConverter(dayOfTheWeek:String) -> Int
    {
        switch dayOfTheWeek.lowercased() {
        case "sunday":
            return 0
        case "monday":
            return 1
        case "tuesday":
            return 2
        case "wednesday":
            return 3
        case "thursday":
            return 4
        case "friday":
            return 5
        case "saturday":
            return 6
        default:
            return 0
        }
        
        return 0
        
    }
    
    func getAllRestrictedSpace ()
    {
        var allSpaces = restrictedSpaceModel.getAllRestrictedSpace()
        
        allSpaces.sort{
            (DayStringToNumConverter(dayOfTheWeek:$0.dayOfTheWeek),$0.startTime.hour, $0.startTime.minutes) <
                                   (DayStringToNumConverter(dayOfTheWeek:$1.dayOfTheWeek),$1.startTime.hour, $1.startTime.minutes)
                            }
        
        self.allRestrictedSpaces=allSpaces
        
        //DayStringToNumConverter(dayOfTheWeek:$0.dayOfTheWeek),
    }
    
    func getRandomColor() -> Color
    {
        
        let colorArray = [Color.green,Color.pink,Color.red,Color.orange,Color.blue,Color(UIColor.systemTeal)].shuffled()
            
        return colorArray[0]
        
    }
    func getRestrictedSpaceColor (restrictedSpace:RestrictedSpace) -> Color
    {
       return restrictedSpaceModel.getRestrictedSpaceColor(restrictedSpace:restrictedSpace)
    }
    func CreateRestrictedSpace(name:String,color:Color,startTimeHour:String,startTimeMinutes:String,endTimeHour:String,endTimeMinutes:String,dayOfTheWeek:String,difficulty:String) throws
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
            try restrictedSpaceModel.CreateRestrictedSpace(name:name,color:color.description,startTime: startTime, endTime: endTime, dayOfTheWeek: dayOfTheWeek,difficulty:difficulty)
        }
        catch RestrictedSpaceError.alreadyScheduled {
            throw RestrictedSpaceError.alreadyScheduled
        }
        catch{
            
        }
        
    }
    
    
}

