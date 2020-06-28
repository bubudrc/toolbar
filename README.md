# toolbar
Programmatically constructing an NSToolbar

<center><img src="images/automatic_toolbar_style.png" width=40%></center>

Learn how to programmatically create an `NSToolbar` with `NSToolbarItem` and `NSToolbarItemGroup` elements in order to get expected behavior like overflow items for free.

<center><img src="images/toolbar_overflow_1.png" width=40%></center>

As of macOS Catalina, you can also set the `isBordered` element to gain an NSButton look and feel for free without having to set the `view` property of `NSToolbarItem`.

This example also goes over how to create  `NSToolbarItemGroup` to create an item that looks like an `NSSegmentedControl` that will automatically turn into a dropdown menu when space becomes limited. It will also add itself as a submenu to the overflow menu if the width space becomes severely limited.

<center><img src="images/automatic_toolbar_style_shortened.png" width=40%></center>
