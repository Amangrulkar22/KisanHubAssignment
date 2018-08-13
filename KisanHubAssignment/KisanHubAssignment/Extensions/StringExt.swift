//
//  StringExt.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 13/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation


// MARK: - String Extension
extension String {
    
    /// Remove multiple spaces and add single space
    ///
    /// - Returns: return string
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
