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
    var tags: String
    var personal: Bool
    var toread: Bool

    init() {
        self.url = NSURL()
        self.description = ""
        self.tags = ""
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
                        addBookmark(url: url, title: title, shared: isPrivate, description: description, tags: tags, toread: isReadLater)
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
        }.onAppear {
            do {
                try getPageDataFromExtensionContext()
            } catch {
                //              self.isShowingAlert = true
                print("oops")
            }
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

    func addBookmark(url: String, title: String, shared: Bool, description: String = "", tags: String, toread: Bool = false) {
        let groupDefaults = UserDefaults(suiteName: "group.ml.simplepinkt")!
        let userToken = groupDefaults.string(forKey: "userToken")! as String
        let shared = !shared

        var urlQuery = URLComponents()
        urlQuery.scheme = "https"
        urlQuery.host = "api.pinboard.in"
        urlQuery.path = "/v1/posts/add"
        urlQuery.queryItems = [
            URLQueryItem(name: "url", value: url),
            URLQueryItem(name: "description", value: title),
            URLQueryItem(name: "extended", value: description),
            URLQueryItem(name: "tags", value: tags),
            URLQueryItem(name: "shared", value: String(shared)),
            URLQueryItem(name: "toread", value: String(toread)),
            URLQueryItem(name: "auth_token", value: userToken),
            URLQueryItem(name: "format", value: "json")
        ]

        let task = URLSession.shared.dataTask(with: urlQuery.url!) { data, _, error in
            if let data = data {
                let resultCode = self.parseJSON(data: data, key: "result_code")
                if resultCode == "200" {
                    print("Success")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }

        task.resume()
    }

    func parseJSON(data: Data, key: String) -> String? {
        if let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: AnyObject] {
            return jsonObject["\(key)"] as? String
        }
        return nil
    }

    //    private func savePostToCollection(title: String, body: String) {
    //        print(title)
    //        print(body)
    //        LocalStorageManager.standard.saveContext()
    //    }

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
                        //                      self.isShowingAlert = true
                    }

                    guard let itemDict = dict as? NSDictionary else {
                        return
                    }
                    guard let jsValues = itemDict[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else {
                        return
                    }

                    self.title = jsValues["title"] as? String ?? ""
                    self.url = jsValues["URL"] as? String ?? ""
                    self.description = jsValues["selection"] as? String ?? ""
                }
            } else {
                throw WFActionExtensionError.couldNotParseInputItems
            }
        } else {
            throw WFActionExtensionError.couldNotParseInputItems
        }
    }
}
