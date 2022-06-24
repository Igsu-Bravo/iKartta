//
//  iKarttaApp.swift
//  iKartta
//
//  Created by Juan Bravo on 21.6.2022.
//

import SwiftUI
import GoogleMaps

@main
struct iKarttaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        
        // TODO: Get this secret from somewhere
        GMSServices.provideAPIKey("KEY HERE")

    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
