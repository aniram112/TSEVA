//
//  LowPolyController.swift
//  SuperColorPicker
//
//  Created by Marina Roshchupkina on 28.04.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import Foundation
import UIKit
import LowPoly

class LowPolyController: UIViewController {
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var sourceImage: UIImage!
    
    @IBOutlet weak var levelControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerBtnAction()
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        
    }
    
    @IBAction func levelChanged(_ sender: Any) {
        //DispatchQueue.global(qos: .utility).async { [self] in
            lowPolyfy()
        //}
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func backToATapped(_ sender: Any) {
        imageView.image?.writeToPhotoAlbum(image: imageView.image ?? UIImage())
        performSegue(withIdentifier: "mainScreen", sender: self)
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
    func imagePickerBtnAction()
    {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            sourceImage = imageView.image
            // imageViewPic.contentMode = .scaleToFill
        }
        picker.dismiss(animated: true, completion: nil)
        
        // надо ресайз поумнее
        if (sourceImage.size.height*sourceImage.size.width>640*640){
            var scale = 640 / sourceImage.size.height
            if (sourceImage.size.width>sourceImage.size.height){
                scale = 640 / sourceImage.size.width
            }
            
            sourceImage = sourceImage.aspectFittedToHeight(sourceImage.size.height*scale)
        }
        lowPolyfy()
    }
    
    func lowPolyfy(){
        print("entered")
        
        guard let image = sourceImage else {
            return
        }
        guard let imageModel = Image.load(image: image) else {
            return
        }
        defer {
            imageModel.deallocate()
        }
        
        /* detect edges, get all points of edges*/
        let points = Sobel().edgePoints(imageModel)
    
        /* pick out some points from the point set */
        var selectedPoints = [Point]()
        let selectRatio: Int = (levelControl.selectedSegmentIndex+1) * 10
        let selectCount = points.count / selectRatio
        for i in 0..<selectCount {
            let point = points[i * selectRatio]
            let vertex = Point(x: point.x, y: point.y)
            selectedPoints.append(vertex)
        }
        
        /* add some randomly generated points into it */
        let possionPoints = Poisson().discSample(Double(imageModel.width), height: Double(imageModel.height), minDistance: Double(imageModel.width) / Double(selectRatio), newPointsCount: 30)
        selectedPoints.append(contentsOf: possionPoints)
        
        /* output triangles with Delaunay Triangulation  */
        let triangles = Delaunay().triangulate(selectedPoints)
    
        
        /* draw image */
        UIGraphicsBeginImageContextWithOptions(CGSize(width: (image.cgImage?.width)!, height: (image.cgImage?.height)!), true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setAllowsAntialiasing(false)
        context.setStrokeColor(UIColor.clear.cgColor)
        context.setLineWidth(0.5)
        for (_, triangle) in triangles.enumerated()  {
            let centroid = triangle.centroid()
            guard let fillColor = imageModel.getPixelColor(x: Int(centroid.x), y: Int(centroid.y))?.cgColor else {
                return
            }
            context.setFillColor(fillColor)
            context.setStrokeColor(UIColor.yellow.cgColor)
            context.setLineWidth(0.5)
            context.move(to: triangle.p0.cgPoint())
            context.addLine(to: triangle.p1.cgPoint())
            context.addLine(to: triangle.p2.cgPoint())
            context.addLine(to: triangle.p0.cgPoint())
            context.closePath()
            context.fillPath()
        }
        guard let outputImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return
        }
        imageView.image = outputImage
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let cgpoint = tapGestureRecognizer.location(in: tapGestureRecognizer.view)
        let color = imageView.getPixelColorAt(point: cgpoint)
        print(color)
        //okButton.backgroundColor = color
        //App.shared.imageColor = color
    }
}


