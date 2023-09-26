//
//  VisionOSSeniorContrastCheckerApp.swift
//  VisionOSSeniorContrastChecker
//
//  Created by Jden Kim on 9/26/23.
//

import SwiftUI

@main
struct VisionOSSeniorContrastCheckerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
