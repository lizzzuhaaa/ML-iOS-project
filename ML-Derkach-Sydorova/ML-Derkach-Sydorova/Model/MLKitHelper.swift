//
//  ModelWorking.swift
//  ML-Derkach-Sydorova
//

import Foundation

import FirebaseMLModelDownloader
import TensorFlowLite
import MLKit
import MLKitImageLabelingCustom
import MLKitObjectDetectionCustom


class MLKitHelper {
    
    private let imageLabeler: ImageLabeler
    
    init() {
        guard let labelerPath = Bundle.main.path(forResource: "model", ofType: "tflite")
        else{
            fatalError("Modeln trashnulas`")
        }
        
        // Our custom image labeler
        let localLabelerModel: LocalModel = LocalModel(path: labelerPath)
        let labelerOptions = CustomImageLabelerOptions(localModel: localLabelerModel)
        labelerOptions.confidenceThreshold = NSNumber(value: 0.0)
        imageLabeler = ImageLabeler.imageLabeler(options: labelerOptions)
    }
    
    func processLabels(_ visionImage: VisionImage, completion: @escaping ([String: Float]) -> Void) {
        var stylesValue: [String:Float] = [:]
        imageLabeler.process(visionImage) { labels, err in
            guard let labels = labels,
                  !labels.isEmpty else {
                print("No objects were detected")
                completion([:])
                return
            }
            if labels[0].index == 2{
                completion([:])
            }
            for label in labels {
                
                if label.index != 2{
                    stylesValue[label.text] = label.confidence
                }
                print("\(label.index): \(label.text), \(label.confidence)")
            }
            completion(stylesValue)
        }
    }
    
    
    func processImage(uiImage: UIImage, completion: @escaping ([String: Float]) -> Void) {
        let visionImage: VisionImage = VisionImage(image: uiImage)
        visionImage.orientation = uiImage.imageOrientation
        
        processLabels(visionImage){stylesValue in
            completion(stylesValue)
        }
    }
    
    
}
