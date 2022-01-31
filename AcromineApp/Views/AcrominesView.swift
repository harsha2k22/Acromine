//
//  AcrominesView.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//

import Foundation
import UIKit


class AcrominesView: UIView {

    var viewModel:AcromineViewModel?
    var tableview = UITableView()
    var segment = UISegmentedControl(items: ["sf","lf"])
    var errorLabel = UILabel()
    init(viewModel: AcromineViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        configureView()
    }
    
    func configureView() {
        self.addSubview(segment)
        self.backgroundColor = .white
            //UIColor(red: 40.0/255.0, green: 53.0/255.0, blue: 64.0/225.0, alpha: 1)
        segment.selectedSegmentIndex = 0
        let guide = self.safeAreaLayoutGuide
        segment.backgroundColor = UIColor(red: 40.0/255.0, green: 53.0/255.0, blue: 64.0/225.0, alpha: 1)
        let font = UIFont.systemFont(ofSize: 20)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor:UIColor.white ], for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor:UIColor(red: 40.0/255.0, green: 53.0/255.0, blue: 64.0/225.0, alpha: 1) ], for: .selected)

        segment.anchor(top: guide.topAnchor, paddingTop: 16, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 16, right: self.trailingAnchor, paddingRight: 16, centerX: nil, centerY: nil, width: 0, height: 30)
        segment.addTarget(self, action: #selector(self.didChangeSegment), for: .valueChanged)
        
        self.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 160.0
        tableview.separatorStyle = .singleLine
        
        tableview.register(AcrominesTableViewCell.self, forCellReuseIdentifier: AcrominesTableViewCell.identifer)
        tableview.tableFooterView = UIView()
        tableview.keyboardDismissMode = .onDrag
        tableview.anchor(top: segment.bottomAnchor, paddingTop: 10, bottom: self.bottomAnchor, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 0, right: self.trailingAnchor, paddingRight: 0, centerX: nil, centerY: nil, width: 0, height: 0)
        
        self.addSubview(errorLabel)
        errorLabel.textColor = .black
        errorLabel.font = UIFont.systemFont(ofSize: 15)
        errorLabel.text = ""
        errorLabel.numberOfLines = 2
        errorLabel.textAlignment = .center
        errorLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 16, right: self.trailingAnchor, paddingRight: 16, centerX: self.centerXAnchor, centerY: self.centerYAnchor, width: 0, height: 40)


    }
    @objc func didChangeSegment() {
        viewModel?.acromineType = segment.selectedSegmentIndex == 0 ? .sf  : .lf
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension AcrominesView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.acromines.value.first?.lfs?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: AcrominesTableViewCell.identifer) as? AcrominesTableViewCell
        let lfs = viewModel?.acromines.value.first?.lfs?[indexPath.row]
        itemCell?.configureCell(lfs: lfs)
        return itemCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
