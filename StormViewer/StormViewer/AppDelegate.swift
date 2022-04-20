//
//  AppDelegate.swift
//  StormViewer
//
//  Created by Nick Jenson on 4/19/22.
//

import AppKit

// NSObject: base class for AppKit
// NSApplicationDelegate: provides default behavior of functionality
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // called automatically as needed
    // terminates application once final window is closed
    // delegate is used in StormViewerApp.swift with @NSApplicationDelegateAdaptor
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
