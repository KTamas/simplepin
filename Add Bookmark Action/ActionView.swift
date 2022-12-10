//
//  ActionView.swift
//  Add Bookmark Action
//
//  Created by KTamas on 12/10/22.
//  Copyright © 2022 Mathias Lindholm. All rights reserved.
//

import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

enum WFActionExtensionError: Error {
    case userCancelledRequest
    case couldNotParseInputItems
}
struct Bookmark {
    var url: NSURL
    var description: String
    var tags: [String]
    var personal: Bool
    var toread: Bool

    init() {
        self.url = NSURL()
        self.description = ""
        self.tags = []
        self.personal = false
        self.toread = false
    }
}

struct ActionView: View {
    @Environment(\.extensionContext) private var extensionContext: NSExtensionContext!
    @Environment(\.managedObjectContext) private var managedObjectContext

//    @AppStorage(WFDefaults.defaultFontIntegerKey, store: UserDefaults.shared) var fontIndex: Int = 0

//    @FetchRequest(
//        entity: WFACollection.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \WFACollection.title, ascending: true)]
//    ) var collections: FetchedResults<WFACollection>

    @State private var url: String = ""
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    @State private var isPrivate: Bool = false
    @State private var isReadLater: Bool = false
//    @State private var isShowingAlert: Bool = false
//    @State private var selectedBlog: WFACollection?

//    private var draftsCollectionName: String {
//        guard UserDefaults.shared.string(forKey: WFDefaults.serverStringKey) == "https://write.as" else {
//            return "Drafts"
//        }
//        return "Anonymous"
//    }

    private var controls: some View {
            HStack {
                Group {
                Button(
                    action: { extensionContext.cancelRequest(withError: WFActionExtensionError.userCancelledRequest) },
                    label: { Image(systemName: "xmark.circle").imageScale(.large) }
                )
                .accessibilityLabel(Text("Cancel"))
                Spacer()
                Button(
                    action: {
                        savePostToCollection(title: title, body: description)
                        extensionContext.completeRequest(returningItems: nil, completionHandler: nil)
                    },
                    label: { Image(systemName: "square.and.arrow.down").imageScale(.large) }
                )
                .accessibilityLabel(Text("Create new Bookmark"))
                }
                .padding()
            }
    }
    
    var body: some View {
        VStack {
            controls
            Form {
                Section(header: Text("Basics")) {
                    TextField("URL", text: $url)
                        .keyboardType(.URL)
                        .textContentType(.URL)
                    TextField("Title", text: $title)
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                }
                Section(header: Text("Tags (separated by spaces)")) {
                    TextField("Tags", text: $tags)
                }
                Section(header: Text("Attributes")) {
                    Toggle(isOn: $isPrivate) {
                        Text("Private")
                    }
                    Toggle(isOn: $isReadLater) {
                        Text("Read Later")
                    }
                }
            }
            .padding(.bottom, 24)
        }
    }
//        .alert(isPresented: $isShowingAlert, content: {
//            Alert(
//                title: Text("Something Went Wrong"),
//                message: Text("WriteFreely can't create a draft with the data received."),
//                dismissButton: .default(Text("OK"), action: {
//                    extensionContext.cancelRequest(withError: WFActionExtensionError.couldNotParseInputItems)
//                }))
//        })
//        .onAppear {
//            do {
//                try getPageDataFromExtensionContext()
//            } catch {
//                self.isShowingAlert = true
//            }
//        }
//    }

    private func savePostToCollection(title: String, body: String) {
        print(title)
        print(body)
//        let post = WFAPost(context: managedObjectContext)
//        post.createdDate = Date()
//        post.title = title
//        post.body = body
//        post.status = PostStatus.local.rawValue
//        post.collectionAlias = collection?.alias
//        switch fontIndex {
//        case 1:
//            post.appearance = "sans"
//        case 2:
//            post.appearance = "wrap"
//        default:
//            post.appearance = "serif"
//        }
//        if let languageCode = Locale.current.languageCode {
//            post.language = languageCode
//            post.rtl = Locale.characterDirection(forLanguage: languageCode) == .rightToLeft
//        }
//        LocalStorageManager.standard.saveContext()
    }

    private func getPageDataFromExtensionContext() throws {
        if let inputItem = extensionContext.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {

                let typeIdentifier: String

                if #available(iOS 15, *) {
                    typeIdentifier = UTType.propertyList.identifier
                } else {
                    typeIdentifier = kUTTypePropertyList as String
                }

                itemProvider.loadItem(forTypeIdentifier: typeIdentifier) { (dict, error) in
                    if let error = error {
                        print("⚠️", error)
//                        self.isShowingAlert = true
                    }

                    guard let itemDict = dict as? NSDictionary else {
                        return
                    }
                    guard let jsValues = itemDict[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else {
                        return
                    }

                    let pageTitle = jsValues["title"] as? String ?? ""
                    let pageURL = jsValues["URL"] as? String ?? ""
                    let pageSelectedText = jsValues["selection"] as? String ?? ""

                    if pageSelectedText.isEmpty {
                        // If there's no selected text, create a Markdown link to the webpage.
                        self.description = "[\(pageTitle)](\(pageURL))"
                    } else {
                        // If there is selected text, create a Markdown blockquote with the selection
                        // and add a Markdown link to the webpage.
                        self.description = """
                        > \(pageSelectedText)
                        Via: [\(pageTitle)](\(pageURL))
                        """
                    }
                }
            } else {
                throw WFActionExtensionError.couldNotParseInputItems
            }
        } else {
            throw WFActionExtensionError.couldNotParseInputItems
        }
    }
}
