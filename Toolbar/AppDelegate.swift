//
//  AppDelegate.swift
//  Toolbar
//
//  Created by Guzman, Mario on 4/29/19.
//  Copyright © 2019 Digimarc Corp. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool
    {
        return true 
    }
}