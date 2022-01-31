//
//  UIViewExtensions.swift
//  AcromineApp
//
//  Created by Harsha Vemula on 01/30/22.
//
import Foundation
import UIKit

public extension UIView {

  func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?, width: CGFloat, height: CGFloat)
    {
      translatesAutoresizingMaskIntoConstraints = false
      if let top = top {
        topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
      }
      if let bottom = bottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
      }
      if let right = right {
        //rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
      }
      if let left = left {
        //leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
      }
      if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
      }
      if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
      }
      if let centerX = centerX {
        centerXAnchor.constraint(equalTo: centerX).isActive = true
      }
      if let centerY = centerY {
        centerYAnchor.constraint(equalTo: centerY).isActive = true
      }
    }
    
    func addDropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 4
    }
}



extension String {
    
    var formatedDateTime:String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let dateFromServer = formatter.date(from: self)

        var formattedDateStr = ""
        if let date = dateFromServer {
            let actualDF = DateFormatter()
            actualDF.dateFormat = "EEE, dd MMM yyyy hh:mm a"
            formattedDateStr =  actualDF.string(from: date)
            return formattedDateStr
            
        }
        
        return formattedDateStr
    }
}
