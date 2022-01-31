//
//  AcromineViewModel.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//

import Foundation
import Alamofire

protocol AcromineViewModelProtocol {
    func fetchAcromines(query:String, type:AcromineType)
    func setError(_ message: String)
    var acromines: Observable<AcromineModel> { get  set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}


class AcromineViewModel: AcromineViewModelProtocol {
    
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)
    var apiManager: APIManagerProtocol?
    var acromines: Observable<AcromineModel> = Observable([])
    var acromineType: AcromineType = .sf

    
    init(manager: APIManagerProtocol = APIManagerMock.shared) {
        self.apiManager = manager
    }

    func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchAcromines(query:String, type:AcromineType) {
        showIndicator()
        self.apiManager?.getAcromines(query: query, type: type, onCompletion: { [weak self] (respModel, error) in
            hideIndicator()
            if let model = respModel {
                if model.count > 0 {
                    self?.acromines.value = model //Observable(response)
                    return
                }
                self?.setError(StringConstants.noRecordsMessage)
            }
            if let error = error {
                self?.setError(error.localizedDescription)
            }
        })
    }

    func setError(_ message: String) {
        self.errorMessage.value = message //Observable(message)
        self.error.value = true //Observable(true)
    }

}
