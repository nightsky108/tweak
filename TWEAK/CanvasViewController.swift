//
//  CanvasViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit
import CoreImage
import Accelerate

class CanvasViewController: UIViewController {
    
    @IBAction func savePhoto(_ sender: Any) {
        let croppedImage = self.cropToBounds(image: (self.updatedImageForSave)!, width: 300.34, height: 200.34)
        UIImageWriteToSavedPhotosAlbum(croppedImage, nil, nil, nil)
        let alert = UIAlertController(title: "Saved", message: "Photo has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func setScale(_ sender: UISlider) {
        let scale = CGFloat(sender.value * 1.0)
        if (scale == CGFloat(exactly: 0.0)) {
            return
        }
        guard let image = self.updatedImage else {
            return
        }
        print(scale)
        let newSize = CGSize(width: scale * (self.image?.size.width)!, height: scale * image.size.height)
        self.updatedImage = resizeImageWith(newSize: newSize)
        
        let croppedImage = self.cropToBounds(image: (self.updatedImage)!, width: 300.34, height: 200.34)
        
        let white = UIColor.black
        let backgroundSize = CGSize(width: self.selectedImage.frame.size.width , height: self.selectedImage.frame.size.height)
        let backgroundImage = self.makeImageWithColor(white, size: backgroundSize)
        
        let updatedImage = self.imageByCombiningImage(firstImage: backgroundImage,  secondImage:  croppedImage)

        self.selectedImage.image = updatedImage
        
        print(self.updatedImage!.size.width)
    }
    struct Filter {
        let filterName: String
        var filterEffectValue: Any?
        var filterEffectValueName: String?
        
        init(filterName: String, filterEffectValue: Any?, filterEffectValueName: String?) {
            self.filterName = filterName
            self.filterEffectValue = filterEffectValue
            self.filterEffectValueName = filterEffectValueName
        }
    }
    
    var filters: [Filter] = [Filter(filterName: "CISepiaTone", filterEffectValue: 0.9, filterEffectValueName: "inputIntensity"),
                             Filter(filterName: "CIColorMonochrome", filterEffectValue: 0.9, filterEffectValueName: "inputIntensity"),
                             Filter(filterName: "CIDiscBlur", filterEffectValue: 0.9, filterEffectValueName: "inputRadius"),
                             Filter(filterName: "CICMYKHalftone", filterEffectValue: 0.9, filterEffectValueName: "inputUCR"),
                             Filter(filterName: "CIVignetteEffect", filterEffectValue: 0.9, filterEffectValueName: "inputIntensity"),
                             Filter(filterName: "CIVignette", filterEffectValue: 0.9, filterEffectValueName: "inputIntensity"),
                             Filter(filterName: "CIColorPosterize", filterEffectValue: 0.9, filterEffectValueName: "inputLevels"),
                             Filter(filterName: "CIColorMonochrome", filterEffectValue: 0.9, filterEffectValueName: "inputIntensity")
    ]
    
    @IBAction func gotoHome(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("home"), object: nil)
    }
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var canvasCollectionView: UICollectionView!
    var canvasActiveNo = 100
    var imageArray = [UIImage]()
    var image : UIImage?
    var updatedImage : UIImage?
    var updatedImageForSave : UIImage?
    
    var canvasArray = [UIImage(named: "curves.png"), UIImage(named: "tone.png"),
                       UIImage(named: "exposure.png"), UIImage(named: "contrast.png"),
                       UIImage(named: "shadow.png"), UIImage(named: "highlights.png"), UIImage(named: "saturation.png"), UIImage(named: "grain.png"), UIImage(named: "temperature.png"), UIImage(named: "sharpen.png"), UIImage(named: "straighten.png"), UIImage(named: "crop.png"), UIImage(named: "clear_edit.png")]
    
    var canvasActiveArray = [UIImage(named: "curves.png"), UIImage(named: "tone.png"),
                             UIImage(named: "exposure-active.png"), UIImage(named: "contrast-active.png"),
                             UIImage(named: "shadow-active.png"), UIImage(named: "highlights-active.png"),
                             UIImage(named: "saturation-active.png"), UIImage(named: "grain-active.png"),
                             UIImage(named: "temperature-active.png"), UIImage(named: "sharpen-active.png"),
                             UIImage(named: "straighten-active.png"), UIImage(named: "crop-active.png"),
                             UIImage(named: "clear_edit-active.png")]
    
    private func applyCanvasTo() -> UIImage? {
        let inputImage = self.image!
        let context = CIContext(options: [CIContextOption.useSoftwareRenderer: false])
        var processedImage = self.image
        if let currentFilter = CIFilter(name: "CILanczosScaleTransform") {
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(5, forKey: kCIInputScaleKey)
            currentFilter.setValue(0.5, forKey: kCIInputAspectRatioKey)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    processedImage = UIImage(cgImage: cgimg)
                    // do something interesting with the processed image
                    
                }
            }
        }
        
        
        return processedImage
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        posX = 0
        posY = contextSize.height * 0.2
        cgwidth = contextSize.width
        cgheight = contextSize.height * 0.6
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image    
    }
   
    func imageByCombiningImage(firstImage: UIImage, secondImage: UIImage) -> UIImage? {
        
        var newImageWidth  = max(firstImage.size.width,  secondImage.size.width )
        var newImageHeight = max(firstImage.size.height, secondImage.size.height)
        
        newImageWidth = firstImage.size.width
        newImageHeight = firstImage.size.height
        let newImageSize = CGSize(width : newImageWidth, height: newImageHeight)
        
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        
        let firstImageDrawX  = round((newImageSize.width  - firstImage.size.width  ) / 2)
        let firstImageDrawY  = round((newImageSize.height - firstImage.size.height ) / 2)
        
        let secondImageDrawX = round((newImageSize.width  - secondImage.size.width ) / 2)
        let secondImageDrawY = round((newImageSize.height - secondImage.size.height) / 2)
        
        firstImage .draw(at: CGPoint(x: firstImageDrawX,  y: firstImageDrawY))
        secondImage.draw(at: CGPoint(x: secondImageDrawX, y: secondImageDrawY))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        
        return image
    }
    
    func resizeImageWith(newSize: CGSize) -> UIImage? {
        
        let horizontalRatio = newSize.width / self.image!.size.width
        let verticalRatio = newSize.height / self.image!.size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        
        let newSize = CGSize(width: self.image!.size.width * ratio, height: self.image!.size.height * ratio)
    
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.image!.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let white = UIColor.white
        let transparent = UIColor.clear
        let backgroundSize = CGSize(width: self.selectedImage!.frame.size.width , height: self.selectedImage!.frame.size.height)
        let backgroundImageWithWhite = self.makeImageWithColor(white, size: backgroundSize)
        let backgroundImageWithTransparent = self.makeImageWithColor(transparent, size: backgroundSize)
        
        let updatedImageWithWhite = self.imageByCombiningImage(firstImage: backgroundImageWithWhite,  secondImage:  newImage!)
        
        let updatedImageWithTransparent = self.imageByCombiningImage(firstImage: backgroundImageWithTransparent,  secondImage:  newImage!)
        self.updatedImageForSave = updatedImageWithTransparent
        
//        let croppedImage = self.cropToBounds(image: (self.updatedImage)!, width: 300.34, height: 200.34)
//
//        let black = UIColor.black
//        let backgroundBlackSize = CGSize(width: self.selectedImage.frame.size.width , height: self.selectedImage.frame.size.height)
//        let backgroundBlackImage = self.makeImageWithColor(black, size: backgroundBlackSize)
//
//        updatedImage = self.imageByCombiningImage(firstImage: backgroundBlackImage,  secondImage:  croppedImage)
        
        return updatedImageWithWhite
    }
    
    func makeImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    private func cropImage(inputImage: UIImage) -> UIImage?
    {
        let inputImage = self.updatedImage!
        
        let originX = self.selectedImage.frame.origin.x
        let originY = self.selectedImage.frame.origin.y + inputImage.size.height * 0.2
        let cropWidth = inputImage.size.width
        let cropHeight = inputImage.size.height * 0.6
        let cropRect = CGRect(x:originX,
                              y:originY,
                              width:cropWidth,
                              height:cropHeight)
         // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropRect)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canvasCollectionView.delegate = self
        self.canvasCollectionView.dataSource = self
        self.selectedImage.image = self.image
        self.updatedImage = self.image
        //        self.sliderView.isHidden = true
        //        let heiConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0.0)
        //        self.sliderView.addConstraint(heiConstraint)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension  CanvasViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = canvasCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        if (indexPath.row != self.canvasActiveNo) {
            cell.canvasImg.image = self.canvasArray[indexPath.row]
        }
        else {
            cell.canvasImg.image = self.canvasActiveArray[indexPath.row]
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.canvasArray.count
        
    }
    
}

extension CanvasViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 0.0
        height = Double(canvasCollectionView.frame.height * 0.8)
        return CGSize(width: height * 0.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.canvasActiveNo = indexPath.row
       
        if (indexPath.row == self.canvasArray.count - 1) {
//            NotificationCenter.default.post(name: Notification.Name("payment"), object: nil)
        }
        
//        let croppedImage = self.cropToBounds(image: (self.updatedImage)!, width: 300.34, height: 200.34)
//        
//        let white = UIColor.black
//        let backgroundSize = CGSize(width: self.selectedImage.frame.size.width , height: self.selectedImage.frame.size.height)
//        let backgroundImage = self.makeImageWithColor(white, size: backgroundSize)
//        
//        let updatedImage = self.imageByCombiningImage(firstImage: backgroundImage,  secondImage:  croppedImage)
//        self.updatedImage = croppedImage
//        self.selectedImage.image = updatedImage
        //            let heiConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 56.0)
        //            self.sliderView.addConstraint(heiConstraint)
        canvasCollectionView.reloadData()
        
    }
    
    
}
