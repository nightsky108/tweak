//
//  FilterViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit
import CoreImage

class FilterViewController: UIViewController {
    

    @IBAction func savePhoto(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(self.updatedImage!, nil, nil, nil)
        let alert = UIAlertController(title: "Saved", message: "Photo has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
    
    @IBAction func setIntensity(_ sender: UISlider) {
        let intensity = sender.value
        guard let image = self.updatedImage else {
            return
        }
        
        self.updatedImage = applyFilterTo(image: image, filterEffect: Filter( filterName: filters[self.filterActiveNo].filterName, filterEffectValue: intensity * 1, filterEffectValueName: filters[self.filterActiveNo].filterEffectValueName))
        self.selectedImage.image = self.updatedImage
    }
    
    private func applyFilterTo1(image: UIImage, filterEffect: Filter) -> UIImage? {
        guard let cgImage = image.cgImage,
            let openGLContext = EAGLContext(api: .openGLES3) else {
                return nil
        }
        
//        let context = CIContext(eaglContext: openGLContext)
        let context = CIContext(options: nil)
        let ciImage = CIImage(cgImage: cgImage)
        let filter = CIFilter(name: filterEffect.filterName)
        
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let filterEffectValue = filterEffect.filterEffectValue,
            let filterEffectValueName = filterEffect.filterEffectValueName {
            filter?.setValue(filterEffectValue, forKey: filterEffectValueName)
        }
        
        var filteredImage: UIImage?
        
        if let output = filter?.value(forKey: kCIInputImageKey) as? CIImage,
            let cgiImageResult = context.createCGImage(output, from: output.extent) {
            filteredImage = UIImage(cgImage: cgiImageResult)
        }
        
        return filteredImage
    }
    
    private func applyFilterTo(image: UIImage, filterEffect: Filter) -> UIImage? {
        let inputImage = self.image!
        let context = CIContext(options: nil)
        var processedImage = self.image
        if let currentFilter = CIFilter(name: filterEffect.filterName) {
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            if (filterEffect.filterEffectValueName != nil) {
             currentFilter.setValue(filterEffect.filterEffectValue, forKey: filterEffect.filterEffectValueName!)
            }
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    processedImage = UIImage(cgImage: cgimg)
                    // do something interesting with the processed image
                   
                }
            }
        }
    
        
        return processedImage
    }
    
    

    @IBAction func gotoHome(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("home"), object: nil)
    }
    
    @IBOutlet weak var selectedImage: UIImageView!
    var filterActiveNo = 0
    var imageArray = [UIImage]()
    var image : UIImage?
    var updatedImage : UIImage?
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    var filterImage = UIImage(named: "payment-slider.png")
    var filterImageActive = UIImage(named: "payment-slider.png")
    
    var filterArray = [UIImage(named: "curves.png"), UIImage(named: "tone.png"),
                       UIImage(named: "exposure.png"), UIImage(named: "contrast.png"),
                       UIImage(named: "shadow.png"), UIImage(named: "highlights.png"), UIImage(named: "saturation.png"), UIImage(named: "grain.png"), UIImage(named: "temperature.png"), UIImage(named: "sharpen.png"), UIImage(named: "straighten.png"), UIImage(named: "crop.png"), UIImage(named: "clear_edit.png")]
    
    var filterActiveArray = [UIImage(named: "curves.png"), UIImage(named: "tone.png"),
                             UIImage(named: "exposure-active.png"), UIImage(named: "contrast-active.png"),
                             UIImage(named: "shadow-active.png"), UIImage(named: "highlights-active.png"),
                             UIImage(named: "saturation-active.png"), UIImage(named: "grain-active.png"),
                             UIImage(named: "temperature-active.png"), UIImage(named: "sharpen-active.png"),
                             UIImage(named: "straighten-active.png"), UIImage(named: "crop-active.png"),
                             UIImage(named: "clear_edit-active.png")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
        self.selectedImage.image = self.image
        self.updatedImage = self.image

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}


extension  FilterViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.img.layer.cornerRadius = cell.frame.width / 20.0
        
        if (indexPath.row != self.filterActiveNo) {
            cell.img.image = applyFilterTo(image: self.image!, filterEffect: filters[indexPath.row])
        }
        else {
            cell.img.image = self.image
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.filters.count
        
    }
    
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 0.0
        height = Double(filterCollectionView.frame.height * 0.8)
        return CGSize(width: height * 0.9, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.filterActiveNo = indexPath.row
        
        guard let image = self.image else {
            return
        }
        self.selectedImage.image = applyFilterTo(image: image, filterEffect: filters[indexPath.row])
        
        
        //            let heiConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 56.0)
        //            self.sliderView.addConstraint(heiConstraint)
        filterCollectionView.reloadData()
        
    }
    
    
}
