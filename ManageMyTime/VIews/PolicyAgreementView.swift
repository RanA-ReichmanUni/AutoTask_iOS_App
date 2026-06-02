//
//  PolicyAgreementView.swift
//  ManageMyTime
//

import SwiftUI

struct PolicyAgreementView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack(spacing: 20) {
           /* Image(systemName: "doc.text.magnifyingglass")
                .resizable()
               .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .padding(.top, 10)*/
            
            Text("Updated Policies")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("We've updated our Terms of Service and Privacy Policy. Please review them to continue.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(spacing: 10) {
                Button(action: {
                    if let url = URL(string: "http://auto-task-automatic.flycricket.io/privacy.html") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Privacy Policy")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .underline()
                }
                
                Button(action: {
                    if let url = URL(string: "http://auto-task-automatic.flycricket.io/terms.html") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Terms of Service")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .underline()
                }
            }
            .padding(.vertical, 5)
            
            HStack(spacing: 15) {
                Button(action: {
                    // Cancel and exit app
                    exit(0)
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    // Agree and continue
                    ViewRouter.setAgreedToCurrentPolicy()
                    viewRouter.showPolicyPopup = false
                }) {
                    Text("Agree")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 5)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct PolicyAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyAgreementView()
    }
}
