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
    
    //  Standard examples of `NSToolbarItem`
    let toolbarItemUserAccounts = NSToolbarItem.Identifier("ToolbarUserAccountsItem")
    let toolbarItemMoreInfo = NSToolbarItem.Identifier("ToolbarMoreInfoItem")
    
    /// Example of `NSMenuToolbarItem`
    let toolbarMoreActions = NSToolbarItem.Identifier("ToolbarMoreActionsItem")
    
    /// Example of `NSSharingServicePickerToolbarItem`
    let toolbarShareButtonItem = NSToolbarItem.Identifier(rawValue: "ToolbarShareButtonItem")
    
    /// Example of `NSToolbarItemGroup`
    let toolbarPickerItem = NSToolbarItem.Identifier("ToolbarPickerItemGroup")
    
    /// Example of `NSSearchToolbarItem`
    let toolbarSearchItem = NSToolbarItem.Identifier("ToolbarSearchItem")
    
    //  `visibilityPriority` is set to `.low` for these items to demostrate how
    //  to make some items disappear before others when space gets a bit tight.
    let toolbarNewFolder = NSToolbarItem.Identifier("ToolbarNewFolderItem")
    let toolbarNewSmartFolder = NSToolbarItem.Identifier("ToolbarNewSmartFolderItem")
    let toolbarNewBurnFolder = NSToolbarItem.Identifier("ToolbarNewBurnFolderItem")
    
    /// Items for the `NSMenuToolbarItem`
    var actionsMenu: NSMenu = {
        var menu = NSMenu(title: "")
        let menuItem1 = NSMenuItem(title: "Get info", action: nil, keyEquivalent: "")
        let menuItem2 = NSMenuItem(title: "Quick Look", action: nil, keyEquivalent: "")
        let menuItem3 = NSMenuItem.separator()
        let menuItem4 = NSMenuItem(title: "Move to trash...", action: nil, keyEquivalent: "")
        menu.items = [menuItem1, menuItem2, menuItem3, menuItem4]
        return menu
    }()
    
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
            if #available(macOS 11.0, *) {
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
        if  itemIdentifier == self.toolbarMoreActions {
            let toolbarItem = NSMenuToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.showsIndicator = true // Make `false` if you don't want the down arrow to be drawn
            toolbarItem.menu = self.actionsMenu
            toolbarItem.label = "More Actions"
            toolbarItem.paletteLabel = "More Actions"
            toolbarItem.toolTip = "Displays available actions"
            if  #available(macOS 11.0, *) {
                toolbarItem.image = NSImage(systemSymbolName: "ellipsis.circle", accessibilityDescription: "")
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
            if  #available(macOS 11.0, *) {
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
            if  #available(macOS 11.0, *) {
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
            toolbarItem.visibilityPriority = .low
            if  #available(macOS 11.0, *) {
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
            toolbarItem.visibilityPriority = .low
            if  #available(macOS 11.0, *) {
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
            toolbarItem.visibilityPriority = .low
            if  #available(macOS 11.0, *) {
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
        
        if  itemIdentifier == self.toolbarShareButtonItem {
            let shareItem = NSSharingServicePickerToolbarItem(itemIdentifier: itemIdentifier)
            shareItem.toolTip = "Share"
            shareItem.delegate = self
            if  #available(macOS 11.0, *) {
                shareItem.menuFormRepresentation?.image = NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: nil)
            }
            return shareItem
        }
        
        if  itemIdentifier == self.toolbarSearchItem {
            //  `NSSearchToolbarItem` is macOS 11 and higher only
            if  #available(macOS 11.0, *) {
                let searchItem = NSSearchToolbarItem(itemIdentifier: itemIdentifier)
                searchItem.resignsFirstResponderWithCancel = true
                searchItem.searchField.delegate = self
                searchItem.toolTip = "Search"
                return searchItem
            }
        }
        
        return nil
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        if  #available(macOS 11.0, *) {
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
                self.toolbarMoreActions,
                NSToolbarItem.Identifier.space,
                self.toolbarSearchItem,
                self.toolbarShareButtonItem
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
                self.toolbarNewBurnFolder,
                self.toolbarMoreActions,
                NSToolbarItem.Identifier.space,
                self.toolbarShareButtonItem
            ]
        }
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [
            self.toolbarMoreActions,
            self.toolbarItemUserAccounts,
            self.toolbarItemMoreInfo,
            self.toolbarNewFolder,
            self.toolbarNewSmartFolder,
            self.toolbarNewBurnFolder,
            self.toolbarPickerItem,
            self.toolbarShareButtonItem,
            self.toolbarSearchItem,
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
        
        //  Maybe you want to not enable more actions if nothing in your app
        //  is selected. Set your condition inside this `if`.
        if  item.itemIdentifier == self.toolbarMoreActions {
            return true
        }
        
        //  Maybe you want to not enable the share menu if nothing in your app
        //  is selected. Set your condition inside this `if`.
        if  item.itemIdentifier == self.toolbarShareButtonItem {
            return true
        }
        
        //  Feel free to add more conditions for your other toolbar items here...
        
        return true
    }
    
    // MARK: - Toolbar Item Custom Actions
    
    @IBAction func testAction(_ sender: Any)
    {
        if  let toolbarItem = sender as? NSToolbarItem {
            print("Clicked \(toolbarItem.itemIdentifier)")
        }
    }
}

// Conforming to the delegate for the share toolbar item.
extension MainWindowController: NSSharingServicePickerToolbarItemDelegate
{
    func items(for pickerToolbarItem: NSSharingServicePickerToolbarItem) -> [Any] {
        // Compose an array of items that are sharable such as text, URLs, etc.
        // depending on the context of your application (i.e. what the user
        // current has selected in the app and/or they tab they're in).
        let sharableItems = [URL(string: "https://www.apple.com/")!]
        return sharableItems
    }
}

// Conforming to the delegate for the share toolbar item.
extension MainWindowController: NSSearchFieldDelegate
{
    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        print("Search field did start receiving input")
    }
    
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        print("Search field did end receiving input")
        sender.resignFirstResponder()
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
