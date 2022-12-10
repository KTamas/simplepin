//
//  Helpers.swift
//  Simplepin
//
//  Created by Florian Mari on 16/03/2020.
//  Copyright © 2020 Mathias Lindholm. All rights reserved.
//

import UIKit

class Helpers {
    static func open(scheme: String) {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                print("Open \(scheme): \(success)")
            })
        }
    }
}
