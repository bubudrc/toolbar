//
//  ViewController.swift
//  Toolbar
//
//  Created by Guzman, Mario on 4/29/19.
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
    
    //  For Segmented Control style Toolbar Item Group
    let toolbarPickerItem = NSToolbarItem.Identifier("ToolbarPickerItemGroup")
    
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
            newToolbar.centeredItemIdentifier = self.toolbarPickerItem
            
            unwrappedWindow.title = "Window Title"
            if #available(OSX 10.16, *) {
                unwrappedWindow.toolbarStyle = .automatic
                unwrappedWindow.subtitle = "Window Subtitle"
            } else {
                // Fallback on earlier versions
            }
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
            toolbarItem.toolTip = "Open Settings panel"
            if #available(OSX 10.16, *) {
                toolbarItem.image = NSImage(systemSymbolName: "gearshape", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.advancedName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarItemUserAccounts {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Accounts"
            toolbarItem.paletteLabel = "Accounts"
            toolbarItem.toolTip = "Open Accounts panel"
            if #available(OSX 10.16, *) {
                toolbarItem.image = NSImage(systemSymbolName: "at", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.userAccountsName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarItemMoreInfo {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "More Info"
            toolbarItem.paletteLabel = "More Info"
            toolbarItem.toolTip = "See more info"
            if #available(OSX 10.16, *) {
                toolbarItem.image = NSImage(systemSymbolName: "info.circle.fill", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.infoName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarNewFolder {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "New Folder"
            toolbarItem.paletteLabel = "New Folder"
            toolbarItem.toolTip = "Create new folder"
            if #available(OSX 10.16, *) {
                toolbarItem.image = NSImage(systemSymbolName: "folder.badge.plus", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.folderName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarNewSmartFolder {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Smart Folder"
            toolbarItem.paletteLabel = "Smart Folder"
            toolbarItem.toolTip = "Create new smart folder"
            if #available(OSX 10.16, *) {
                toolbarItem.image = NSImage(systemSymbolName: "folder.badge.gear", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.folderSmartName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarNewBurnFolder {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Burn"
            toolbarItem.paletteLabel = "Burn"
            toolbarItem.toolTip = "Burn selected folder"
            if #available(OSX 10.16, *) {
                toolbarItem.image = NSImage(systemSymbolName: "burn", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.folderBurnableName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == self.toolbarPickerItem {
            let titles = ["General", "Advanced", "Sync"]
            
            // This will either be a segmented control or a drop down depending
            // on your available space.
            //
            // NOTE: When you set the target as nil and use the string method
            // to define the Selector, it will go down the Responder Chain,
            // which in this app, this method is in AppDelegate. Neat!
            let toolbarItem = NSToolbarItemGroup(itemIdentifier: itemIdentifier, titles: titles, selectionMode: .selectOne, labels: titles, target: nil, action: Selector(("toolbarPickerDidSelectItem:")) )
            
            toolbarItem.label = "View"
            toolbarItem.paletteLabel = "View"
            toolbarItem.toolTip = "Change the selected view"
            toolbarItem.selectedIndex = 0
            return toolbarItem
        }
        
        return nil
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        if #available(OSX 10.16, *) {
            // The preferred toolbar style in macOS 11 takes up the left side
            // for the window title and subtitle. Let's go with a different
            // toolbar item set for this. You can change the window toolbar
            // style if you want something like macOS 10.15 or older layout.
            return [
                    NSToolbarItem.Identifier.flexibleSpace,
                    self.toolbarPickerItem,
                    NSToolbarItem.Identifier.flexibleSpace,
                    self.toolbarNewFolder,
                    self.toolbarNewSmartFolder,
                    NSToolbarItem.Identifier.space,
                    self.toolbarItemUserAccounts,
                    self.toolbarItemSettings
            ]
        } else {
            // Use the preferred toolbar item set for older versions of macOS.
            return [
                    self.toolbarItemUserAccounts,
                    self.toolbarItemMoreInfo,
                    NSToolbarItem.Identifier.flexibleSpace,
                    self.toolbarPickerItem,
                    NSToolbarItem.Identifier.flexibleSpace,
                    self.toolbarNewFolder,
                    self.toolbarNewSmartFolder,
                    NSToolbarItem.Identifier.space,
                    self.toolbarNewBurnFolder,
                    self.toolbarItemSettings
            ]
        }
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [self.toolbarItemSettings,
                self.toolbarItemUserAccounts,
                self.toolbarItemMoreInfo,
                self.toolbarNewFolder,
                self.toolbarNewSmartFolder,
                self.toolbarNewBurnFolder,
                self.toolbarPickerItem,
                NSToolbarItem.Identifier.space,
                NSToolbarItem.Identifier.flexibleSpace]
    }
    
    func toolbarWillAddItem(_ notification: Notification)
    {
        // print("~ ~ toolbarWillAddItem: \(notification.userInfo!)")
    }
    
    func toolbarDidRemoveItem(_ notification: Notification)
    {
        // print("~ ~ toolbarDidRemoveItem: \(notification.userInfo!)")
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        // Return the identifiers you'd like to show as "selected" when clicked.
        // Similar to how they look in typical Preferences windows.
        return []
    }
    
    // MARK: - Toolbar Validation
    
    func validateToolbarItem(_ item: NSToolbarItem) -> Bool
    {
        // let itemIdentifier = item.itemIdentifier
        // print("Validating \(itemIdentifier)")
        
        // Use this method to enable/disable toolbar items as user takes certain
        // actions. For example, so items may not be applicable if a certain UI
        // element is selected. This is called on your behalf. Return false if
        // the toolbar item needs to be disabled.
        
        return true
    }
    
    // MARK: - Toolbar Item Custom Actions
    
    @IBAction func testAction(_ sender: Any)
    {
        if let toolbarItem = sender as? NSToolbarItem {
            print("Clicked \(toolbarItem.itemIdentifier)")
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
