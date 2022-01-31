//
//  APIManagerMock.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//

import Foundation
import Alamofire

struct APIManagerMock : APIManagerProtocol {
    static let shared = APIManagerMock()
    private init() { }
    
    func getAcromines(query: String, type: AcromineType, onCompletion: @escaping (AcromineModel?,Error?) -> Void) {
        let jsonData = readJSON("Acromines")
        do {
            let codableModel = try JSONDecoder().decode(AcromineModel.self, from: jsonData)
            onCompletion(codableModel, nil)
        } catch let error {
            onCompletion(nil,error)
        }
    }
}
