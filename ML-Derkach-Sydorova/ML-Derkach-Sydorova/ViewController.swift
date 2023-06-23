//
//  ViewController.swift
//  ML-Derkach-Sydorova
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var photoChooser: UIButton!
    @IBOutlet private weak var camOpener: UIButton!
    
    
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
//        {
//            picker.takePicture()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTap()
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
    }
    
}

