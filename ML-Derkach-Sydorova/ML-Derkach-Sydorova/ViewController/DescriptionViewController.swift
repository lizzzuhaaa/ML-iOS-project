//
//  ViewControllerSub.swift
//  ML-Derkach-Sydorova
//

import Foundation
import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var possibleStyle: UILabel!
    @IBOutlet private weak var descriptionStyle: UILabel!
    @IBOutlet private weak var funnyCatImg: UIImageView!
    
    var descriptionText: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setDescriptionStyle(_ stylesDesc:[String]){
        self.possibleStyle.text = stylesDesc[0]
        self.descriptionStyle.text = stylesDesc[2] + stylesDesc[3]
        
        
//        let description = stylesDesc[2] + stylesDesc[3]
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.systemFont(ofSize: 17), .font: UIFont.systemFont(ofSize: 13)
//        ]
//        let attributedString = NSAttributedString(string: description, attributes: attributes)
//        self.descriptionStyle.attributedText = attributedString
//        
        
//        var percentOtherCategories = UILabel()
//        percentOtherCategories.text = stylesDesc[3]
//        percentOtherCategories.font.withSize(13)
//        self.descriptionStyle += percentOtherCategories
        
        funnyCatImg.translatesAutoresizingMaskIntoConstraints = false
        funnyCatImg.widthAnchor.constraint(equalToConstant: 300).isActive = true
        funnyCatImg.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.funnyCatImg.image = UIImage(named: stylesDesc[1])
        
    }
    
    
}

