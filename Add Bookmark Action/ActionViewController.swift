import SwiftUI

class ActionViewController: UIViewController {

    //    let moc = LocalStorageManager.standard.container.viewContext

    override var prefersStatusBarHidden: Bool { true }

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = ActionView()
            .environment(\.extensionContext, extensionContext)
        //            .environment(\.managedObjectContext, moc)

        view = UIHostingView(rootView: contentView)
        view.isOpaque = true
        view.backgroundColor = .systemBackground
    }

}

////
////  ActionViewController.swift
////  Add Bookmark Action
////
////  Created by KTamas on 12/10/22.
////  Copyright © 2022 Mathias Lindholm. All rights reserved.
////
//
// import UIKit
// import MobileCoreServices
// import UniformTypeIdentifiers
//
// class ActionViewController: UIViewController {
//
//    @IBOutlet weak var imageView: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Get the item[s] we're handling from the extension context.
//
//        // For example, look for an image and place it into an image view.
//        // Replace this with something appropriate for the type[s] your extension supports.
//        var imageFound = false
//        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
//            for provider in item.attachments! {
//                if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
//                    // This is an image. We'll load it, then place it in our image view.
//                    weak var weakImageView = self.imageView
//                    provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil, completionHandler: { (imageURL, error) in
//                        OperationQueue.main.addOperation {
//                            if let strongImageView = weakImageView {
//                                if let imageURL = imageURL as? URL {
//                                    strongImageView.image = UIImage(data: try! Data(contentsOf: imageURL))
//                                }
//                            }
//                        }
//                    })
//
//                    imageFound = true
//                    break
//                }
//            }
//
//            if (imageFound) {
//                // We only handle one image, so stop looking for more.
//                break
//            }
//        }
//    }
//
//    @IBAction func done() {
//        // Return any edited content to the host app.
//        // This template doesn't do anything, so we just echo the passed in items.
//        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
//    }
//
// }
//
// protocol OptionsTableViewDelegate: AnyObject {
//    func didEnterInformation(data: Bookmark)
// }
//
// class OptionsTableViewController: UITableViewController {
//    weak var delegate: OptionsTableViewDelegate? = nil
//    var passedBookmark = Bookmark()
//    let groupDefaults = UserDefaults(suiteName: "group.ml.simplepinkt")!
//
//    var descriptionCell: UITableViewCell = UITableViewCell()
//    var tagsCell: UITableViewCell = UITableViewCell()
//    var shareCell: UITableViewCell = UITableViewCell()
//    var toreadCell: UITableViewCell = UITableViewCell()
//    var descriptionLabel: UITextField = UITextField()
//    var tagsLabel: UITextField = UITextField()
//    var privateSwitch: UISwitch = UISwitch()
//    var toreadSwitch: UISwitch = UISwitch()
//
//    override func loadView() {
//        super.loadView()
//
//        self.title = "Options"
//
//        self.descriptionLabel = UITextField(frame: self.descriptionCell.contentView.bounds.insetBy(dx: 15, dy: 0))
//        self.descriptionLabel.placeholder = "Description"
//        self.descriptionLabel.autocorrectionType = .default
//        self.descriptionLabel.autocapitalizationType = .sentences
//        self.descriptionCell.addSubview(self.descriptionLabel)
//
//        self.tagsLabel = UITextField(frame: self.tagsCell.contentView.bounds.insetBy(dx: 15, dy: 0))
//        self.tagsLabel.placeholder = "Tags (separated by space)"
//        self.tagsLabel.autocorrectionType = .default
//        self.tagsLabel.autocapitalizationType = .none
//        self.tagsCell.addSubview(self.tagsLabel)
//
//        self.shareCell.textLabel?.text = "Private"
//        self.privateSwitch.isOn = groupDefaults.bool(forKey: "privateByDefault")
//        self.shareCell.accessoryView = privateSwitch
//        self.shareCell.addSubview(self.privateSwitch)
//
//        self.toreadCell.textLabel?.text = "Read Later"
//        self.toreadSwitch.isOn = groupDefaults.bool(forKey: "toreadByDefault")
//        self.toreadCell.accessoryView = toreadSwitch
//        self.toreadCell.addSubview(self.toreadSwitch)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = nil
//
//        descriptionLabel.text = passedBookmark.description
//        tagsLabel.text = passedBookmark.tags.joined(separator: " ")
//        privateSwitch.isOn = passedBookmark.personal
//        toreadSwitch.isOn = passedBookmark.toread
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//
//        guard let description = descriptionLabel.text,
//            let tags = tagsLabel.text?.components(separatedBy: " ") else { return }
//
//        passedBookmark.description = description
//        passedBookmark.tags = tags
//        passedBookmark.personal = privateSwitch.isOn
//        passedBookmark.toread = toreadSwitch.isOn
//
//        delegate?.didEnterInformation(data: passedBookmark)
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {switch(indexPath.row) {
//        case 0: return self.descriptionCell
//        case 1: return self.tagsCell
//        case 2: return self.shareCell
//        case 3: return self.toreadCell
//        default: fatalError("Unknown row in section 0")
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = nil
//    }
//
//    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        false
//    }
// }
