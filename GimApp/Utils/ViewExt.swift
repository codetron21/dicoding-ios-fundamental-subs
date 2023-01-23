//
//  ViewExt.swift
//  GimApp
//
//  Created by Apple on 23/01/23.
//

import UIKit

extension UILabel {
    func addStarFill(_ text:String, pointSize: CGFloat){
        let attachment = NSTextAttachment()
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize)
        let image =  UIImage(systemName: "star.fill",withConfiguration: configuration)?.withTintColor(UIColor.white)
        attachment.image = image
        
        let attributedImage = NSMutableAttributedString(attachment: attachment)
        let attributedTextSpacing = NSAttributedString(string: " ")
        let attributedText = NSAttributedString(string: text)
        
        let completeText = NSMutableAttributedString(string: "")
        
        completeText.append(attributedImage)
        completeText.append(attributedTextSpacing)
        completeText.append(attributedText)
        
        self.attributedText = completeText
    }
}

