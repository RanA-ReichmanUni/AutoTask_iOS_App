//
//  ViewRouter.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

class ViewRouter: ObservableObject {
    
    // MARK: - Policy Agreement Settings
    // Increment `policyVersion` whenever there is a major policy change to prompt the user again.
    // We removed `requiresPolicyAgreement` because `policyVersion` elegantly handles this:
    // If you don't want to prompt, just leave `policyVersion` as is. When you do want to prompt, increment it.
    static let policyVersion = 1
    
    static var hasAgreedToCurrentPolicy: Bool {
        return UserDefaults.standard.integer(forKey: "agreedPolicyVersion") >= policyVersion
    }
    
    static func setAgreedToCurrentPolicy() {
        UserDefaults.standard.set(policyVersion, forKey: "agreedPolicyVersion")
    }
    
    init() {
        if (!UserDefaults.standard.bool(forKey: "didLaunchBefore")) {
            // New Install: The onboarding screen already covers this, 
            // so we implicitly mark the current policy as agreed.
            ViewRouter.setAgreedToCurrentPolicy()
            currentPage = "PageViewController1"
        } else {
            // Normal flow for existing user
            currentPage = "MainUI2"
            // Show popup if they haven't agreed to the latest policy
            if !ViewRouter.hasAgreedToCurrentPolicy {
                showPolicyPopup = true
            }
        }
    }
    
    @Published var currentPage: String
    @Published var showPolicyPopup: Bool = false
    
}
