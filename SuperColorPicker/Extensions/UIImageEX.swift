//
//  UIImageEX.swift
//  SuperColorPicker
//
//  Created by Marina Roshchupkina on 13.05.2022.
//  Copyright © 2022 Sonia Kucheryavaya. All rights reserved.
//

import UIKit
extension UIImage {
    func mergedSideBySide(with otherImage: UIImage) -> UIImage {
        let mergedWidth = max(self.size.width, otherImage.size.width)
        let mergedHeight = self.size.height + otherImage.size.height
        let mergedSize = CGSize(width: mergedWidth, height: mergedHeight)
        UIGraphicsBeginImageContext(mergedSize)
        self.draw(in: CGRect(x: 0, y: 0, width: mergedWidth, height: self.size.height))
        otherImage.draw(in: CGRect(x: 0, y: self.size.height, width: mergedWidth, height: mergedHeight))
        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return mergedImage ?? self
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage
    {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
