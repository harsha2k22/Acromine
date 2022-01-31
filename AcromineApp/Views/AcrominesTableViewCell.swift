//
//  AcrominesTableViewCell.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//

import UIKit

class AcrominesTableViewCell: UITableViewCell {

    static var identifer = "AcrominesTableViewCell"
    
    var lfsTitle:UILabel = UILabel()
    var freqLabel:UILabel = UILabel()
    var sinceLabel:UILabel = UILabel()
    
    var bgView:UIView = UIView()
    var shadowLayer = ShadowView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        
    }
    fileprivate func configureView()  {

        self.contentView.insertSubview(shadowLayer, at: 0)
        self.contentView.insertSubview(bgView, at: 1)
        self.selectionStyle = .none
        lfsTitle.numberOfLines = 0
        lfsTitle.font = UIFont.boldSystemFont(ofSize: 14)
        freqLabel.font = UIFont.systemFont(ofSize: 12)
        sinceLabel.font = UIFont.systemFont(ofSize: 12)
        
        bgView.addSubview(lfsTitle)
        bgView.addSubview(freqLabel)
        bgView.addSubview(sinceLabel)
        bgView.layer.cornerRadius = 6
        bgView.layer.masksToBounds = true
        

        bgView.anchor(top: self.contentView.topAnchor, paddingTop: 10, bottom: self.contentView.bottomAnchor, paddingBottom: 10, left: self.contentView.leadingAnchor, paddingLeft: 10, right: self.contentView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
        bgView.backgroundColor = .white
        
        shadowLayer.anchor(top: self.contentView.topAnchor, paddingTop: 10, bottom: self.contentView.bottomAnchor, paddingBottom: 10, left: self.contentView.leadingAnchor, paddingLeft: 10, right: self.contentView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)


        lfsTitle.anchor(top: bgView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: bgView.leadingAnchor, paddingLeft: 10, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
        lfsTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        
        freqLabel.anchor(top: lfsTitle.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: lfsTitle.leadingAnchor, paddingLeft: 0, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 18)
        
        sinceLabel.anchor(top: freqLabel.bottomAnchor, paddingTop: 0, bottom: bgView.bottomAnchor, paddingBottom: 10, left: lfsTitle.leadingAnchor, paddingLeft: 0, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(lfs:LF?) {
        lfsTitle.text = lfs?.lf ?? ""
        freqLabel.text = "\(StringConstants.frequency) \(lfs?.freq ?? 0)"
        sinceLabel.text = "\(StringConstants.since) \(lfs?.since ?? 0)"
        
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
    }
}


class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
