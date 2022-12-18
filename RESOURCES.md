# Resources

Resources I've found useful while developing.

## Basics

* [The original PR with Swift 3 -> 5 conversion, support for larger screen sizes etc.](https://github.com/thisismatu/simplepin/pull/1)

## Search bar fix

* [UISearchBar](https://developer.apple.com/documentation/uikit/uisearchbar)
* [Search Bar Guide](https://guides.codepath.com/ios/Search-Bar-Guide)
* [updateSearchResultsForSearchController:](https://developer.apple.com/documentation/uikit/uisearchresultsupdating/1618658-updatesearchresultsforsearchcont)
* [Displaying Searchable Content by Using a Search Controller](https://developer.apple.com/documentation/uikit/view_controllers/displaying_searchable_content_by_using_a_search_controller)
* [UISearchController Tutorial: Getting Started](https://www.kodeco.com/4363809-uisearchcontroller-tutorial-getting-started) — This and the above one are what helped me fixed the search bug


## Share View Controller
* [ShareViewController example](https://github.com/mattneub/Programming-iOS-Book-Examples/blob/master/bk2ch13p636actionExtension/Shoebox/ShareViewController.swift)
* [Customizing SLComposeSheetConfigurationItem](https://stackoverflow.com/questions/57502583/customizing-slcomposesheetconfigurationitem)

## Action Extension
* [How can create a share sheet/view with SwiftUI for iOS 13 ?](https://developer.apple.com/forums/thread/123951)
* [NSExtensionActivationSupportsWebPageWithMaxCount](https://developer.apple.com/documentation/bundleresources/information_property_list/nsextension/nsextensionattributes/nsextensionactivationrule/nsextensionactivationsupportswebpagewithmaxcount)
* [Building the WriteFreely Action Extension in SwiftUI
](https://write.as/angelo/building-the-writefreely-action-extension-in-swiftui) — This is where most of the code is from
* [Add action extension for Safari #198](https://github.com/writefreely/writefreely-swiftui-multiplatform/pull/198/files#diff-afcb76af73e7919c0ab3a2aadea17f21c09fb92f2481da53bfd8a61fc9a1c021) — The code (PR on GitHub)
* [Building forms with SwiftUI: A comprehensive guide](https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide/)
* [NSExtensionContext](https://developer.apple.com/documentation/foundation/nsextensioncontext)
* [Trying to create a share extension to get input from Safari](https://developer.apple.com/forums/thread/132858) — ended up using write.as' solution instead
* [attributedContentText](https://developer.apple.com/documentation/foundation/nsextensionitem/1408297-attributedcontenttext)
* [Converting a NSAttributedString into a NSString using Swift](https://stackoverflow.com/questions/25493122/converting-a-nsattributedstring-into-a-nsstring-using-swift)
* [iOS Share Extension is not working in Chrome](https://stackoverflow.com/questions/38637484/ios-share-extension-is-not-working-in-chrome) — sameish info as the write.as stuff
* [NSExtensionActivationRule for iOS app extension that can share everything](https://stackoverflow.com/questions/36030907/nsextensionactivationrule-for-ios-app-extension-that-can-share-everything) — different things to share
* [IOS Safari URL UTI share sheet](https://stackoverflow.com/questions/43528568/ios-safari-url-uti-share-sheet)
* [hasItemConformingToTypeIdentifier(_:)](https://developer.apple.com/documentation/foundation/nsitemprovider/1403921-hasitemconformingtotypeidentifie)


## UserDefaults
* [How to Use UserDefaults Suites With Swift](https://programmingwithswift.com/how-to-use-userdefaults-suites-with-swift/)

## Random
* [AddObserver](https://developer.apple.com/documentation/foundation/notificationcenter/1411723-addobserver)
* [How NotificationCenter#addObserver(forName:object:queue:using:) works?](https://stackoverflow.com/questions/57008167/how-notificationcenteraddobserverfornameobjectqueueusing-works)
* [HOW TO COMPLETELY REMOVE A FRAMEWORK FROM XCODE?](https://www.appsloveworld.com/coding/xcode/251/how-to-completely-remove-a-framework-from-xcode)
* [What's the difference between Xcode's move to trash and remove reference?](https://stackoverflow.com/questions/10740126/whats-the-difference-between-xcodes-move-to-trash-and-remove-reference)
* [Failed to read values in CFPrefsPlistSource iOS 10](https://stackoverflow.com/questions/38275395/failed-to-read-values-in-cfprefsplistsource-ios-10) — Spurious bug, ignore
* [How do I remove a bridge header without getting errors?](https://stackoverflow.com/questions/32274684/how-do-i-remove-a-bridge-header-without-getting-errors)
* [How to open an URL in Swift?](https://stackoverflow.com/questions/39546856/how-to-open-an-url-in-swift) — no need for ObjC anymore, see also [the source of firefox-ios](https://github.com/mozilla-mobile/firefox-ios/blob/f68f9346c7387363880b9fd207f0fb6c919a1153/Client/Frontend/Browser/MailtoLinkHandler.swift#L12)
* [Declaring URL in Swift 3](https://stackoverflow.com/questions/39543214/declaring-url-in-swift-3)
* [Converting URL to String and back again](https://stackoverflow.com/questions/27062454/converting-url-to-string-and-back-again)
* [Is this the best way to handle a user-entered URL?](https://www.hackingwithswift.com/forums/swiftui/is-this-the-best-way-to-handle-a-user-entered-url/7477)
* [How to convert Swift Bool? -> String?](https://stackoverflow.com/questions/33860733/how-to-convert-swift-bool-string)
* [How to Make an HTTP Request in Swift](https://cocoacasts.com/networking-fundamentals-how-to-make-an-http-request-in-swift)
* [How would I create a UIAlertView in Swift?](https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift)
* [How to respond to view lifecycle events: onAppear() and onDisappear()](https://www.hackingwithswift.com/quick-start/swiftui/how-to-respond-to-view-lifecycle-events-onappear-and-ondisappear)
* [How to show an alert](https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-an-alert)
* [SwiftLint](https://github.com/realm/SwiftLint)

## New

* [How to create a new Xcode project without Storyboard](https://sarunw.com/posts/how-to-create-new-xcode-project-without-storyboard/)
* [To the depth of @objc and dynamic in Swift](https://varun04tomar.medium.com/to-the-depth-of-objc-and-dynamic-in-swift-b5472800b85d)
* [SwiftUI](https://developer.apple.com/xcode/swiftui/)
* [optionals](https://www.programiz.com/swift-programming/optionals)
* [Awesome iOS](https://github.com/vsouza/awesome-ios)
* [SwiftGen](https://github.com/SwiftGen/SwiftGen)
* [Decode - Turn UI back to Code](https://apps.apple.com/app/decode-turn-ui-back-to-code/id1547075542)
* [Displaying live data with Live Activities](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities)
* [Percentage](https://github.com/sindresorhus/Percentage)
* [UIHostingView](https://github.com/sindresorhus/Blear/blob/main/Blear/Utilities.swift#L331)
* [How to create UITableView(TableView) in SwiftUI?](https://gigarad.co/blog/articles/how-to-create-table-view-in-swiftui.html)
