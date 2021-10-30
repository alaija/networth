//
//  CoreDataHelper.swift
//  networth
//
//  Created by Alan Kochev on 10/10/21.
//

import Foundation

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
