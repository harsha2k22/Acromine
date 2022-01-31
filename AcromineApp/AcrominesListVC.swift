//
//  ViewController.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//

import UIKit

class AcrominesListVC: UIViewController {
    var viewModel:AcromineViewModel?
    var queryString = ""
    var acrominesView:AcrominesView {
        return self.view as! AcrominesView
    }
    init(_ viewModel: AcromineViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    override func loadView() {
        self.view = AcrominesView(viewModel: self.viewModel!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        addSearchBar()
        viewModel?.acromines.bind { acromines in
            DispatchQueue.main.async {
                print("Values Count \(acromines.count)")
                print("LFS Count \(self.viewModel?.acromines.value.first?.lfs?.count ?? 0)")
                self.acrominesView.tableview.isHidden = false
                self.acrominesView.errorLabel.isHidden = true
                self.acrominesView.tableview.reloadData()
            }
        }
        viewModel?.errorMessage.bind { message in
            DispatchQueue.main.async {
                print("Error Message \(message ?? "")")
                self.acrominesView.tableview.isHidden = true
                self.acrominesView.errorLabel.isHidden = false
                self.acrominesView.errorLabel.text = message
            }
        }
        
    }
    func addSearchBar() {

        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
        searchBar.placeholder = "Search by Acronyms"
        searchBar.searchTextField.backgroundColor = UIColor(red: 1.0/255.0, green: 8.0/255.0, blue: 18.0/225.0, alpha: 1)
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.delegate = self
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        searchBar.tintColor = .white
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }

}
extension AcrominesListVC : UISearchBarDelegate, UITextFieldDelegate {

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = searchBar.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        if updatedText.count >= 2 {
            queryString = updatedText
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(updateTableViewContent), object: nil)
            self.perform(#selector(updateTableViewContent), with: nil, afterDelay: 0.5)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = ""
        queryString = ""
        return true
    }
    @objc func updateTableViewContent(){
        print("queryString \(queryString)")
        viewModel?.fetchAcromines(query: queryString, type: viewModel?.acromineType ?? .sf)
    }
}


