//
//  DetailViewController.swift
//  iOSCoreMLDemo
//
//  Created by Aravind Vasudevan on 25/07/18.
//  Copyright © 2018 Aravind Vasudevan. All rights reserved.
//

import UIKit
import CoreML
import Vision

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        title = selectedImage
        
        if let imageToLoad = selectedImage {
            let img = UIImage(named: imageToLoad)
            
            let ciImage = CIImage(image: img!)
            let handler = VNImageRequestHandler(ciImage: ciImage!)
            do {
                try handler.perform([classificationRequest])
            } catch {
                print(error)
            }
            
            imageView.image = img
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    lazy var classificationRequest: VNCoreMLRequest = {
        // Load the ML model through its generated class and create a Vision request for it.
        do {
            let model = try VNCoreMLModel(for: dogsvscats().model)
            let request = VNCoreMLRequest(model: model, completionHandler: handleClassification)
            request.imageCropAndScaleOption = .centerCrop
            
            return request
        } catch {
            fatalError("Can't load Vision ML model: \(error).")
        }
    }()
    
    func handleClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNCoreMLFeatureValueObservation]
            else { fatalError("Unexpected result type from VNCoreMLRequest.") }
//        guard let best = observations.first
//            else { fatalError("Can't get best result.") }
        
        DispatchQueue.main.async {
            let prediction = observations.first!.featureValue.multiArrayValue![0]
            print(prediction)
            self.title =  String(prediction == 0 ? "Cat" : "Dog")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
