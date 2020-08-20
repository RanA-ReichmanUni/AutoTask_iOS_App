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
    
    
}

