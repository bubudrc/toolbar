//
//  ViewController.swift
//  Toolbar
//
//  Created by Guzman, Mario on 4/29/19.
//  Copyright © 2019 Digimarc Corp. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSToolbarDelegate, NSToolbarItemValidation
{
    let mainWindowToolbarIdentifier = NSToolbar.Identifier("MainWindowToolbar")
    
    let toolbarItemSettings = NSToolbarItem.Identifier("ToolbarSettingsItem")
    let toolbarItemUserAccounts = NSToolbarItem.Identifier("ToolbarUserAccountsItem")
    let toolbarItemMoreInfo = NSToolbarItem.Identifier("ToolbarMoreInfoItem")
    
    let toolbarNewFolder = NSToolbarItem.Identifier("ToolbarNewFolderItem")
    let toolbarNewSmartFolder = NSToolbarItem.Identifier("ToolbarNewSmartFolderItem")
    let toolbarNewBurnFolder = NSToolbarItem.Identifier("ToolbarNewBurnFolderItem")
    
    //let toolbarGroup = NSToolbarItem.Identifier("ToolbarGroupItem")
    //let toolbarItem1 = NSToolbarItem.Identifier("ToolbarGroupItem1")
    //let toolbarItem2 = NSToolbarItem.Identifier("ToolbarGroupItem2")
    
    override func windowDidLoad()
    {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window
        // controller's window has been loaded from its nib file.
        
        if  let unwrappedWindow = self.window {
            
            let newToolbar = NSToolbar(identifier: self.mainWindowToolbarIdentifier)
            newToolbar.delegate = self
            newToolbar.allowsUserCustomization = true
            newToolbar.autosavesConfiguration = true
            newToolbar.displayMode = .default
            //newToolbar.centeredItemIdentifier = toolbarGroup
            
            unwrappedWindow.toolbar = newToolbar
            unwrappedWindow.toolbar?.validateVisibleItems()
        }
    }
    
    // Toolbar Delegate
    
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem?
    {
        if  itemIdentifier == self.toolbarItemSettings {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Settings"
            toolbarItem.paletteLabel = "Settings"
            toolbarItem.toolTip = "Settings Button"
            toolbarItem.image = NSImage(named: NSImage.advancedName)
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarItemUserAccounts {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Accounts"
            toolbarItem.paletteLabel = "Accounts"
            toolbarItem.toolTip = "Accounts Button"
            toolbarItem.image = NSImage(named: NSImage.userAccountsName)
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarItemMoreInfo {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "More Info"
            toolbarItem.paletteLabel = "More Info"
            toolbarItem.toolTip = "More Info Button"
            toolbarItem.image = NSImage(named: NSImage.infoName)
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarNewFolder {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "New Folder"
            toolbarItem.paletteLabel = "New Folder"
            toolbarItem.toolTip = "New Folder Button"
            toolbarItem.image = NSImage(named: NSImage.folderName)
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarNewSmartFolder {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Smart Folder"
            toolbarItem.paletteLabel = "Smart Folder"
            toolbarItem.toolTip = "New Smart Folder Button"
            toolbarItem.image = NSImage(named: NSImage.folderSmartName)
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarNewBurnFolder {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Burn Folder"
            toolbarItem.paletteLabel = "Burn Folder"
            toolbarItem.toolTip = "New Smart Folder Button"
            toolbarItem.image = NSImage(named: NSImage.folderBurnableName)
            return toolbarItem
        }
        
//        if itemIdentifier == self.toolbarGroup {
//            let toolbarItem = NSToolbarItemGroup(itemIdentifier: itemIdentifier)
//
//            let toolbarItem1 = NSToolbarItem(itemIdentifier: self.toolbarItem1)
//            toolbarItem1.target = self
//            toolbarItem1.action = #selector(testAction(_:))
//            toolbarItem1.label = "Folder"
//            toolbarItem1.paletteLabel = "Folder"
//            toolbarItem1.toolTip = "Folder Button"
//            toolbarItem1.image = NSImage(named: NSImage.folderName)
//
//            let toolbarItem2 = NSToolbarItem(itemIdentifier: self.toolbarItem2)
//            toolbarItem2.target = self
//            toolbarItem2.action = #selector(testAction(_:))
//            toolbarItem2.label = "Smart Folder"
//            toolbarItem2.paletteLabel = "Smart Folder"
//            toolbarItem2.toolTip = "Smart Folder Button"
//            toolbarItem2.image = NSImage(named: NSImage.folderSmartName)
//
//            toolbarItem.subitems = [toolbarItem1, toolbarItem2]
//            toolbarItem.label = "Folder Actions"
//            toolbarItem.paletteLabel = "Folder Actions"
//
//            return toolbarItem
//        }
        
        return nil
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [self.toolbarItemUserAccounts,
                self.toolbarItemMoreInfo,
                NSToolbarItem.Identifier.flexibleSpace,
                //self.toolbarGroup,
                self.toolbarNewFolder,
                self.toolbarNewBurnFolder,
                NSToolbarItem.Identifier.flexibleSpace,
                self.toolbarNewSmartFolder,
                self.toolbarItemSettings]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [self.toolbarItemSettings,
                self.toolbarItemUserAccounts,
                self.toolbarItemMoreInfo,
                // self.toolbarGroup,
                self.toolbarNewFolder,
                self.toolbarNewBurnFolder,
                self.toolbarNewSmartFolder,
                NSToolbarItem.Identifier.space,
                NSToolbarItem.Identifier.flexibleSpace]
    }
    
    func toolbarWillAddItem(_ notification: Notification)
    {
        print("~ ~ toolbarWillAddItem: \(notification.userInfo!)")
    }
    
    func toolbarDidRemoveItem(_ notification: Notification)
    {
        print("~ ~ toolbarDidRemoveItem: \(notification.userInfo!)")
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [self.toolbarItemSettings]
    }
    
    // MARK: - Toolbar Validation
    
    func validateToolbarItem(_ item: NSToolbarItem) -> Bool
    {
        return true
    }
    
    // MARK: - Toolbar Item Custom Actions
    
    @IBAction func testAction(_ sender: Any)
    {
        if let toolbarItem = sender as? NSToolbarItem {
            if  toolbarItem.itemIdentifier != self.toolbarItemSettings {
                self.window?.toolbar?.selectedItemIdentifier = nil
            }
        }
    }
}

class MainWindow: NSWindow
{
    
}

class ViewController: NSViewController
{
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
