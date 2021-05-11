//
//  MainWindowController.swift
//  Toolbar
//
//  Created by Mario Guzman on 5/10/21.
//  Copyright © 2021 Digimarc Corp. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSToolbarItemValidation
{
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
    
    // MARK: - Titlebar Accessory View
    // This view appears below the titlebar or toolbar (if you have one)
    // An example of this would be Safari's "Favorites Bar"
    
    private var titlebarAccessoryViewController: CustomTitlebarAccessoryViewController?
    private var titlebarAccessoryViewControllerToggleButton: NSToolbarItem?
    private var titlebarAccessoryViewIsHidden = false
    
    // MARK: - Window Lifecycle
    
    override func windowDidLoad()
    {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window
        // controller's window has been loaded from its nib file.
        
        self.configureToolbar()
        self.configureTitlebarAccessoryView()
    }
    
    private func configureToolbar()
    {
        if  let unwrappedWindow = self.window {
            
            let newToolbar = NSToolbar(identifier: NSToolbar.Identifier.mainWindowToolbarIdentifier)
            newToolbar.delegate = self
            newToolbar.allowsUserCustomization = true
            newToolbar.autosavesConfiguration = true
            newToolbar.displayMode = .default
            
            // Example on center-pinning a toolbar item
            newToolbar.centeredItemIdentifier = NSToolbarItem.Identifier.toolbarPickerItem
            
            unwrappedWindow.title = "My Great App"
            if #available(macOS 11.0, *) {
                unwrappedWindow.subtitle = "Toolbar Example"
                // The toolbar style is best set to .automatic
                // But it appears to go as .unifiedCompact if
                // you set as .automatic and titleVisibility as
                // .hidden
                unwrappedWindow.toolbarStyle = .unified
            }
            
            // Hiding the title visibility in order to gain more toolbar space.
            // Set this property to .visible or delete this line to get it back.
            unwrappedWindow.titleVisibility = .hidden
            
            unwrappedWindow.toolbar = newToolbar
            unwrappedWindow.toolbar?.validateVisibleItems()
        }
    }
    
    // MARK: - Toolbar Validation
    
    func validateToolbarItem(_ item: NSToolbarItem) -> Bool
    {
        // print("Validating \(item.itemIdentifier)")
        
        // Use this method to enable/disable toolbar items as user takes certain
        // actions. For example, so items may not be applicable if a certain UI
        // element is selected. This is called on your behalf. Return false if
        // the toolbar item needs to be disabled.
        
        //  Maybe you want to not enable more actions if nothing in your app
        //  is selected. Set your condition inside this `if`.
        if  item.itemIdentifier == NSToolbarItem.Identifier.toolbarMoreActions {
            return true
        }
        
        //  Maybe you want to not enable the share menu if nothing in your app
        //  is selected. Set your condition inside this `if`.
        if  item.itemIdentifier == NSToolbarItem.Identifier.toolbarShareButtonItem {
            return true
        }
        
        //  Return false (to disable) this toolbar item if we never create a
        //  titlebar accessory view. This is an example of a conditional
        //  example.
        if  item.itemIdentifier == NSToolbarItem.Identifier.toolbarItemToggleTitlebarAccessory {
            return self.titlebarAccessoryViewController != nil
        }
        
        //  Example of returning false to demonstrate a disabled toolbar item.
        if  item.itemIdentifier == NSToolbarItem.Identifier.toolbarItemMoreInfo {
            return false
        }
        
        //  Feel free to add more conditions for your other toolbar items here...
        
        return true
    }
    
    // MARK: - Toolbar Item Custom Actions
    
    @IBAction func testAction(_ sender: Any)
    {
        if  let toolbarItem = sender as? NSToolbarItem {
            print("Clicked \(toolbarItem.itemIdentifier.rawValue)")
        }
    }
}

// MARK: - Toolbar Delegate

extension MainWindowController: NSToolbarDelegate
{
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem?
    {
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarItemToggleTitlebarAccessory {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(toggleTitlebarAccessory(_:))
            toolbarItem.label = "Hide"
            toolbarItem.paletteLabel = "Toggle additional accessories"
            toolbarItem.toolTip = "Hides additional accessories"
            if  #available(macOS 11.0, *) {
                toolbarItem.image = NSImage(systemSymbolName: "menubar.arrow.up.rectangle", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.touchBarGoUpTemplateName)
            }
            //  Getting a local handle so we can toggle its image, title, and tooltip
            self.titlebarAccessoryViewControllerToggleButton = toolbarItem
            return toolbarItem
        }
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarMoreActions {
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
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarItemUserAccounts {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "Accounts"
            toolbarItem.paletteLabel = "Accounts"
            toolbarItem.toolTip = "Open Accounts panel"
            toolbarItem.visibilityPriority = .low
            if  #available(macOS 11.0, *) {
                toolbarItem.image = NSImage(systemSymbolName: "at", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.userAccountsName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarItemMoreInfo {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(testAction(_:))
            toolbarItem.label = "More Info"
            toolbarItem.paletteLabel = "More Info"
            toolbarItem.toolTip = "See more info"
            toolbarItem.visibilityPriority = .low
            if  #available(macOS 11.0, *) {
                toolbarItem.image = NSImage(systemSymbolName: "info.circle.fill", accessibilityDescription: "")
                toolbarItem.isBordered = true
            } else {
                toolbarItem.image = NSImage(named: NSImage.infoName)
            }
            return toolbarItem
        }
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarPickerItem {
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
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarShareButtonItem {
            let shareItem = NSSharingServicePickerToolbarItem(itemIdentifier: itemIdentifier)
            shareItem.toolTip = "Share"
            shareItem.delegate = self
            if  #available(macOS 11.0, *) {
                shareItem.menuFormRepresentation?.image = NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: nil)
            }
            return shareItem
        }
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarSearchItem {
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
                NSToolbarItem.Identifier.toolbarItemToggleTitlebarAccessory,
                NSToolbarItem.Identifier.toolbarItemUserAccounts,
                NSToolbarItem.Identifier.toolbarItemMoreInfo,
                NSToolbarItem.Identifier.flexibleSpace,
                NSToolbarItem.Identifier.toolbarPickerItem,
                NSToolbarItem.Identifier.flexibleSpace,
                NSToolbarItem.Identifier.toolbarMoreActions,
                NSToolbarItem.Identifier.toolbarShareButtonItem,
                NSToolbarItem.Identifier.toolbarSearchItem
            ]
        } else {
            // Use the preferred toolbar item set for older versions of macOS.
            return [
                NSToolbarItem.Identifier.toolbarItemToggleTitlebarAccessory,
                NSToolbarItem.Identifier.toolbarItemUserAccounts,
                NSToolbarItem.Identifier.toolbarItemMoreInfo,
                NSToolbarItem.Identifier.flexibleSpace,
                NSToolbarItem.Identifier.toolbarPickerItem,
                NSToolbarItem.Identifier.flexibleSpace,
                NSToolbarItem.Identifier.toolbarMoreActions,
                NSToolbarItem.Identifier.toolbarShareButtonItem
            ]
        }
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [
            NSToolbarItem.Identifier.toolbarItemToggleTitlebarAccessory,
            NSToolbarItem.Identifier.toolbarMoreActions,
            NSToolbarItem.Identifier.toolbarItemUserAccounts,
            NSToolbarItem.Identifier.toolbarItemMoreInfo,
            NSToolbarItem.Identifier.toolbarPickerItem,
            NSToolbarItem.Identifier.toolbarShareButtonItem,
            NSToolbarItem.Identifier.toolbarSearchItem,
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
}

// MARK: - Titlebar Accessory View

extension MainWindowController
{
    private func configureTitlebarAccessoryView()
    {
        if  let titlebarController = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier.customTitlebarAccessoryViewController) as? CustomTitlebarAccessoryViewController {
            titlebarController.layoutAttribute = .bottom
            titlebarController.fullScreenMinHeight = titlebarController.view.bounds.height
            self.window?.addTitlebarAccessoryViewController(titlebarController)
            self.titlebarAccessoryViewController = titlebarController
            self.titlebarAccessoryViewController?.isHidden = self.titlebarAccessoryViewIsHidden
        }
    }
    
    @IBAction func toggleTitlebarAccessory(_ sender: Any)
    {
        self.titlebarAccessoryViewIsHidden.toggle()
        self.titlebarAccessoryViewController?.isHidden = self.titlebarAccessoryViewIsHidden
        
        if  self.titlebarAccessoryViewIsHidden {
            self.titlebarAccessoryViewControllerToggleButton?.label = "Show"
            self.titlebarAccessoryViewControllerToggleButton?.toolTip = "Shows additional accessories"
            if  #available(macOS 11.0, *) {
                self.titlebarAccessoryViewControllerToggleButton?.image = NSImage(systemSymbolName: "menubar.arrow.up.rectangle", accessibilityDescription: "")
            } else {
                self.titlebarAccessoryViewControllerToggleButton?.image = NSImage(named: NSImage.touchBarGoUpTemplateName)
            }
        } else {
            self.titlebarAccessoryViewControllerToggleButton?.label = "Hide"
            self.titlebarAccessoryViewControllerToggleButton?.toolTip = "Hides additional accessories"
            if  #available(macOS 11.0, *) {
                self.titlebarAccessoryViewControllerToggleButton?.image = NSImage(systemSymbolName: "menubar.arrow.down.rectangle", accessibilityDescription: "")
            } else {
                self.titlebarAccessoryViewControllerToggleButton?.image = NSImage(named: NSImage.touchBarGoDownTemplateName)
            }
        }
    }
}

// MARK: - Sharing Service Picker Toolbar Item Delegate

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

// MARK: - Search Field Delegate

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
