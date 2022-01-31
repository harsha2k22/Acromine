//
//  APIManager.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//

import Foundation
import Alamofire

enum AcromineType:String {
    case sf = "sf"
    case lf = "lf"
}

protocol APIManagerProtocol {
    func getAcromines(query:String, type:AcromineType, onCompletion: @escaping (AcromineModel?,Error?) -> Void)
}

let BASE_URL = "http://www.nactem.ac.uk/software/acromine/dictionary.py"

struct APIManager : APIManagerProtocol {
    static let shared = APIManager()
    private init() { }
    
    func getAcromines(query: String, type: AcromineType, onCompletion: @escaping (AcromineModel?,Error?) -> Void) {
        guard let url = URL(string: BASE_URL) else {
            return
        }
        let params:[String: String] = [type.rawValue:query]
        AF.request(url, parameters: params)
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    if let array = data as? [[String:Any]] {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: array, options: [])
                            let codableModel = try JSONDecoder().decode(AcromineModel.self, from: jsonData)
                            onCompletion(codableModel, nil)
                            return
                        } catch let error {
                            onCompletion(nil,error)
                        }
                        onCompletion(nil,nil)
                    }
                case .failure(let error):
                    onCompletion(nil,error)
                }
            }
    }
}
