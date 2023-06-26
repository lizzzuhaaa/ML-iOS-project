//
//  ModelWorking.swift
//  ML-Derkach-Sydorova
//
//  Created by лізушка лізушкіна on 25.06.2023.
//

import Foundation

import FirebaseMLModelDownloader
import TensorFlowLite
import MLKit
import MLKitImageLabelingCustom
import MLKitObjectDetectionCustom


class MLKitHelper {
    
    private let objectDetector: ObjectDetector
    private let imageLabeler: ImageLabeler

    init() {
        guard let labelerPath = Bundle.main.path(forResource: "clothes", ofType: "tflite")
        else{
            fatalError("Modeln trashnulas`")
        }
        
        // TODO: insert model for object detection
        guard let detectorPath = Bundle.main.path(forResource: "", ofType: "tflite")
        else {
            fatalError("cringe")
        }
        //let detectorOptions = ObjectDetectorOptions()
        let localDetectorModel: LocalModel = LocalModel(path: detectorPath)
        let detectorOptions = CustomObjectDetectorOptions(localModel: localDetectorModel)
        detectorOptions.detectorMode = .singleImage
        detectorOptions.shouldEnableClassification = true
        detectorOptions.shouldEnableMultipleObjects = true
        detectorOptions.classificationConfidenceThreshold = NSNumber(value: 0.5)
        detectorOptions.maxPerObjectLabelCount = 5
        objectDetector = ObjectDetector.objectDetector(options: detectorOptions)
        
        
        // Our custom image labeler
        let localLabelerModel: LocalModel = LocalModel(path: labelerPath)
        let labelerOptions = CustomImageLabelerOptions(localModel: localLabelerModel)
        labelerOptions.confidenceThreshold = NSNumber(value: 0.0)
        imageLabeler = ImageLabeler.imageLabeler(options: labelerOptions)
    }
    
    func processImage(uiImage: UIImage) -> Void {
        let visionImage: VisionImage = VisionImage(image: uiImage)
        visionImage.orientation = uiImage.imageOrientation
        
        objectDetector.process(visionImage) { objects, error in
            guard error == nil else {
                fatalError()
            }
            guard let objects = objects,
                  !objects.isEmpty else {
                print("No objects were detected")
                // If no objects detected throw alert
                return
            }
            
            for object in objects {
                print("\(object.description):")
                let description = object.labels.enumerated().map { (index, label) in
                    "Label \(index): \(label.text), \(label.confidence)"
                }.joined(separator:"\n")
            }
        }
        
        imageLabeler.process(visionImage) { labels, err in
            guard let labels = labels,
                  !labels.isEmpty else {
                print("No objects were detected")
                return
            }
            for label in labels {
                print("\(label.index): \(label.text), \(label.confidence)")
            }
        }
    }

}
