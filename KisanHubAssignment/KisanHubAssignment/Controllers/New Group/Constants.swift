//
//  Constants.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 10/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import Foundation

/// Google api
let keyGoogleMap: String = "AIzaSyA7p9jGhiFwMjYXxDbw37ahiHSRWMq8Gvs"

/// Api Urls
let Url_Region_Data: String = "https://www.metoffice.gov.uk/climate/uk/summaries/datasets#yearOrdered"
let Url_Google_Map: String = "​https://s3.eu-west-2.amazonaws.com/interview-question-data/farm/farms.json"
let Url_Article_Data: String = "​https://s3.eu-west-2.amazonaws.com/interview-question-data/articles/articles.json"

/// Climate API
let Climate_Base_Url: String = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/%@/date/%@.txt"

let ClimateTable: String = "Climate"

/// Country array
let country: [String] = ["UK", "England", "Wales", "Scotland"]

/// Climate parameter array
let climate_parameters: [String] = ["Tmax", "Tmin", "Sunshine", "Rainfall"]

