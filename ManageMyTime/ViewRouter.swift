//
//  ViewRouter.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
class ViewRouter: ObservableObject {

    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "PageViewController1"
        } else {
            currentPage = "MainUI2"
        }
    }
    
    @Published var currentPage: String
    
}
