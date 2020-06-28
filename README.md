# toolbar
### Programmatically constructing an NSToolbar (AppKit) for macOS.

<img src="images/classic_bordered_full.png" width=80%>
<img src="images/automatic_toolbar_style.png" width=80%>

Learn how to programmatically create an `NSToolbar` with `NSToolbarItem` and `NSToolbarItemGroup` elements in order to get expected behavior like overflow items for free.

<img src="images/toolbar_overflow_1.png" width=80%>

As of macOS Catalina, you can also set the `isBordered` element to gain an NSButton look and feel for free without having to set the `view` property of `NSToolbarItem`.

<img src="images/classic_bordered_compact.png" width=80%>

This example also goes over how to create  `NSToolbarItemGroup` to create an item that looks like an `NSSegmentedControl` that will automatically turn into a dropdown menu when space becomes limited. It will also add itself as a submenu to the overflow menu if the width space becomes severely limited.

<img src="images/classic_compact.png" width=80%>
<img src="images/automatic_toolbar_style_shortened.png" width=80%>
