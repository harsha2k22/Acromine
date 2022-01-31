//
//  AcromineModel.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//

import Foundation
// MARK: - AcromineModelElement
struct AcromineModelElement: Codable {
    let sf: String?
    let lfs: [LF]?
}

// MARK: - LF
struct LF: Codable {
    let lf: String?
    let freq, since: Int?
    let vars: [LF]?
}

typealias AcromineModel = [AcromineModelElement]
