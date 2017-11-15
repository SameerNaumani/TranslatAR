//
//  Scene.swift
//  arkit-testing-2
//
//  Created by Jordan Osterberg on 7/14/17.
//  Copyright © 2017 Shadow Technical Systems, LLC. All rights reserved.
//

import SpriteKit
import ARKit
import Vision


class Scene: SKScene {
    //let inceptionv3model = Inceptionv3()
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            DispatchQueue.global(qos: .background).async {
                do {
                    let model = try VNCoreMLModel(for: TranslatAR2().model)
                    let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                        // Jump onto the main thread
                        DispatchQueue.main.async {
                            // Access the first result in the array after casting the array as a VNClassificationObservation array
                            guard let results = request.results as? [VNClassificationObservation], let result = results.first else {
                                print ("No results?")
                                return
                            }
                            
                            // Create a transform with a translation of 0.2 meters in front of the camera
                            var translation = matrix_identity_float4x4
                            translation.columns.1.z = 0.05
                            let transform = simd_mul(currentFrame.camera.transform, translation)
                            
                            // Add a new anchor to the session
                            let anchor = ARAnchor(transform: transform)
                           /*
                            let uri = "https://api.microsofttranslator.com/V2/Http.svc/Translate"
                            var params:[String : String]=["text":result.identifier, "from": "en", "to":"es","Ocp-Apim-Subscription-Key":"9c84d7c5826b4bb5aa10157fc3e658a7"]
                           */
                            print(result.identifier)
                            //print(result.identifier == "Apple")
                            
                            if result.identifier == "Apple"{
                                ARBridge.shared.anchorsToIdentifiers[anchor] = "manzana"
                            }
                            
                            else if result.identifier == "Wallet"{
                                ARBridge.shared.anchorsToIdentifiers[anchor] = "billetera"
                            }
                            else if result.identifier == "Water Bottle"{
                                ARBridge.shared.anchorsToIdentifiers[anchor] = "botella de agua"
                            }
                            else if result.identifier == "Computer Mouse"{
                                ARBridge.shared.anchorsToIdentifiers[anchor] = "raton de computadora"
                            }
                            else if result.identifier == "Business Card"{
                                ARBridge.shared.anchorsToIdentifiers[anchor] = "la tarjeta comercial"
                            }
 
                            else{
                                ARBridge.shared.anchorsToIdentifiers[anchor] = "no bueno"
                            }
                            
                            // Set the identifier
                            //ARBridge.shared.anchorsToIdentifiers[anchor] = translated
                            //ARBridge.shared.anchorsToIdentifiers[anchor] = result.identifier
                            
                            sceneView.session.add(anchor: anchor)
                        }
                    })
                    
                    let handler = VNImageRequestHandler(cvPixelBuffer: currentFrame.capturedImage, options: [:])
                    try handler.perform([request])
                } catch {}
            }
        }
        
        
    }
    
    /*
    func sendRequest(url: String, parameters: [String: String], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = URL(string: url + "?" + parameterString)!
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        
        return task
    }
    */
    
}

