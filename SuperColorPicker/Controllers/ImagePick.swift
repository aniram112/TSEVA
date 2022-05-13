//
//  ImagePick.swift
//  SuperColorPicker
//
//  Created by Marina Roshchupkina on 12.03.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import Foundation
import UIKit

class ImagePick: UIViewController  {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerBtnAction()
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func backToATapped(_ sender: Any) {
        performSegue(withIdentifier: "mainScreen", sender: self)
    }
    
    func imagePickerBtnAction() {
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
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            // imageViewPic.contentMode = .scaleToFill
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let cgpoint = tapGestureRecognizer.location(in: tapGestureRecognizer.view)
        let color = imageView.getPixelColorAt(point: cgpoint)
        print(color)
        okButton.backgroundColor = color
        App.shared.imageColor = color
    }
}

extension UIImageView {
    func getPixelColorAt(point:CGPoint) -> UIColor{
        
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        layer.render(in: context!)
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0,
                                    green: CGFloat(pixel[1])/255.0,
                                    blue: CGFloat(pixel[2])/255.0,
                                    alpha: CGFloat(pixel[3])/255.0)
        
        pixel.deallocate()
        return color
    }
}


