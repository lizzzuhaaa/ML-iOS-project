//
//  ViewControllerSub.swift
//  ML-Derkach-Sydorova
//

import Foundation
import UIKit

class ViewControllerSub: UIViewController {
    
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
        self.descriptionStyle.text = stylesDesc[2]
        funnyCatImg.translatesAutoresizingMaskIntoConstraints = false
        funnyCatImg.widthAnchor.constraint(equalToConstant: 300).isActive = true
        funnyCatImg.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.funnyCatImg.image = UIImage(named: stylesDesc[1])
        
    }
    
    
}

