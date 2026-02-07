//
//  OpenCallApp.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//

import SwiftUI

@main
struct OpenCallApp: App {
    
    @StateObject var store = AppStore()
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
                .environmentObject(store)
        }
    }
}
