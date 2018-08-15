//
//  EnumTypes.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 15/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation

/// Country enum for selecting country id
///
/// - UK: UK
/// - England: England
/// - Wales: Wales
/// - Scotland: Scotland
public enum Country: Int16 {
    case UK
    case England
    case Wales
    case Scotland
}

/// Country parameter enum for selecting parameter id
///
/// - MaxTemp: MaxTemp
/// - MinTemp: MinTemp
/// - Sunshine: Sunshine
/// - Rainfall: Rainfall
public enum CountryParams: Int16 {
    case MaxTemp
    case MinTemp
    case Sunshine
    case Rainfall
}

public enum ButtonAction: Int {
    case Country
    case Parameter
}
