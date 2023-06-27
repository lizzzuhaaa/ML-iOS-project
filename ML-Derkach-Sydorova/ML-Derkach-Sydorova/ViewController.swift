//
//  ViewController.swift
//  ML-Derkach-Sydorova
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var photoChooser: UIButton!
    @IBOutlet private weak var camOpener: UIButton!
    
    private let mlkithelper: MLKitHelper = MLKitHelper()
    
    private var stylesValueGot: [String:Float]?
    
    private func configureTap(){
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(onTapImageGallery))
        photoChooser.addGestureRecognizer(tapImage)
        
        let tapCam = UITapGestureRecognizer(target: self, action: #selector(onTapCamera))
        camOpener.addGestureRecognizer(tapCam)
    }
    
    //choose an exact image
    @objc func onTapImageGallery(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //take a photo
    @objc func onTapCamera()
    {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //tap on existing photo to go on next page
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if imageView.image != nil && stylesValueGot != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "style_desc") as! ViewControllerSub
            destinationVC.loadViewIfNeeded()
            
            //get style info
            let styleInfo = MessageHelper()
            guard let stylesValueGot = stylesValueGot else{
                return
            }
            styleInfo.getStyles(stylesValueGot)
            destinationVC.setDescriptionStyle(styleInfo.messages)
            
            self.present(destinationVC, animated: true, completion: nil)
        }
    }
    
    //handle alert
    private func alertMessage(_ alert: UIAlertController){
        print("bye")
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTap()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[.originalImage] as? UIImage else
        {
            fatalError("Absent image in imagePickerController")
        }
        self.imageView.image = image
        picker.dismiss(animated: true)
        
        
        mlkithelper.processImage(uiImage: image){ [self]stylesValue in
            
            //catch absent suitable objects
            if stylesValue == [:]{
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                let alert = UIAlertController(title: "Common objects are absent for analysing" , message: "Sorry, but I can`t find any suitable objects on your photo. Choose another one and try again.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(okAction)
                self.alertMessage(alert)
            }
            else{
                stylesValueGot = stylesValue
            }
        }
    }
    
}
