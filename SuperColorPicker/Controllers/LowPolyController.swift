//
//  LowPolyController.swift
//  SuperColorPicker
//
//  Created by Marina Roshchupkina on 28.04.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import Foundation
import UIKit
import LowPolyPack

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
        imageView.image = Methods.lowPolyfy(sourceImage: sourceImage, ratio: (levelControl.selectedSegmentIndex+1) * 10)

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
        imageView.image = Methods.lowPolyfy(sourceImage: sourceImage, ratio: (levelControl.selectedSegmentIndex+1) * 10)
    }

    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let cgpoint = tapGestureRecognizer.location(in: tapGestureRecognizer.view)
        let color = imageView.getPixelColorAt(point: cgpoint)
        print(color)
        //okButton.backgroundColor = color
        //App.shared.imageColor = color
    }
}


