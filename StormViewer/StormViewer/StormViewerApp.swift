//
//  StormViewerApp.swift
//  StormViewer
//
//  Created by Nick Jenson on 4/19/22.
//

import SwiftUI

@main
struct StormViewerApp: App {
    // wrapper tells SwiftUI to use AppDelegate class so app events are forwarded
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // removes Show Tab Bar
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
        }
        // replaces New, Undo/Redo and Cut/Copy/Paste to nothing, removes from menu
        .commands {
            CommandGroup(replacing: .newItem) { }
            CommandGroup(replacing: .undoRedo) { }
            CommandGroup(replacing: .pasteboard) { }
        }
    }
}
