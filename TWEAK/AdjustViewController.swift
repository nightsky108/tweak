//
//  AdjustViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class AdjustViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
        self.selectedImage.image = self.image
        self.updatedImage = self.image
        
        //        self.sliderView.isHidden = true
        //        let heiConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0.0)
        //        self.sliderView.addConstraint(heiConstraint)
        
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.filterCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(self.updatedImage!, nil, nil, nil)
        let alert = UIAlertController(title: "Saved", message: "Photo has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    struct Filter {
        var filterName: String
        var filterEffectValue: Any?
        var filterEffectValueName: String?
        
        init(filterName: String, filterEffectValue: Any?, filterEffectValueName: String?) {
            self.filterName = filterName
            self.filterEffectValue = filterEffectValue
            self.filterEffectValueName = filterEffectValueName
        }
    }
    
    @IBAction func setIntensity(_ sender: UISlider) {
        let intensity = sender.value
        guard let image = self.updatedImage else {
            return
        }
        
        if (filters[self.adjustActiveNo].filterName == "CITemperatureAndTint") {
            self.updatedImage = applyFilterTo(image: image, filterEffect: Filter( filterName: filters[self.adjustActiveNo].filterName, filterEffectValue: CIVector(x: CGFloat(3000.0 * intensity), y: 0), filterEffectValueName: filters[self.adjustActiveNo].filterEffectValueName))
            
            self.selectedImage.image = applyFilterTo(image: image, filterEffect: Filter( filterName: filters[self.adjustActiveNo].filterName, filterEffectValue: CIVector(x: CGFloat(3000.0 * intensity), y: 0), filterEffectValueName: filters[self.adjustActiveNo].filterEffectValueName))
        } else {
            self.updatedImage = applyFilterTo(image: image, filterEffect: Filter( filterName: filters[self.adjustActiveNo].filterName, filterEffectValue: intensity * 1, filterEffectValueName: filters[self.adjustActiveNo].filterEffectValueName))
            
            self.selectedImage.image = applyFilterTo(image: image, filterEffect: Filter( filterName: filters[self.adjustActiveNo].filterName, filterEffectValue: intensity * 1, filterEffectValueName: filters[self.adjustActiveNo].filterEffectValueName))
        }
        
    }
    
    var filters: [Filter] = [Filter(filterName: "CIExposureAdjust", filterEffectValue: 0.9, filterEffectValueName: "inputEV"),
                             Filter(filterName: "CIColorControls", filterEffectValue: 0.9, filterEffectValueName: "inputContrast"),
                             Filter(filterName: "CIExposureAdjust", filterEffectValue: 0.9, filterEffectValueName: "inputEV"),
                             Filter(filterName: "CIColorControls", filterEffectValue: 0.9, filterEffectValueName: "inputContrast"),
                             Filter(filterName: "CIHighlightShadowAdjust", filterEffectValue: 0.9, filterEffectValueName: "inputShadowAmount"),
                             Filter(filterName: "CIHighlightShadowAdjust", filterEffectValue: 0.9, filterEffectValueName: "inputHighlightAmount"),
                             Filter(filterName: "CIColorControls", filterEffectValue: 0.9, filterEffectValueName: "inputSaturation"),
                             Filter(filterName: "CIGammaAdjust", filterEffectValue: 0.9, filterEffectValueName: "inputPower"),
                             Filter(filterName: "CITemperatureAndTint", filterEffectValue: CIVector(x:3000.0, y:0.0), filterEffectValueName: "inputNeutral"),
                             Filter(filterName: "CISharpenLuminance", filterEffectValue: 0.9, filterEffectValueName: "inputSharpness"),
                             Filter(filterName: "CIStraightenFilter", filterEffectValue: 0, filterEffectValueName: "inputAngle"),
                             Filter(filterName: "CIStraightenFilter", filterEffectValue: 0.9, filterEffectValueName: "inputAngle"),
                             Filter(filterName: "CIStraightenFilter", filterEffectValue: 0.9, filterEffectValueName: "inputAngle")
    ]
    
    @IBAction func gotoHome(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("home"), object: nil)
    }
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet var filterCollectionView: UICollectionView!
    var adjustActiveNo = 0
    var imageArray = [UIImage]()
    var image : UIImage?
    var updatedImage : UIImage?
    
    var adjustArray = [UIImage(named: "curves.png"), UIImage(named: "ton.png"),
                       UIImage(named: "exposure.png"), UIImage(named: "contrast1.png"),
                       UIImage(named: "shadow.png"), UIImage(named: "highlights.png"), UIImage(named: "saturation1.png"), UIImage(named: "grain.png"), UIImage(named: "temperature.png"), UIImage(named: "sharpen.png"), UIImage(named: "strighten.png"), UIImage(named: "crop.png"), UIImage(named: "clear-edit.png")]
    
    var adjustNameArray = ["CURVES", "TONES", "EXPOSURE", "CONTRAST", "SHADOW", "HIGHLIGHTS", "SATURATION", "GRAIN",
                           "TEMPERATURE", "SHARPEN", "STRIGHTEN", "CROP", "CLEAR EDIT"]
    
    var adjustActiveArray = [UIImage(named: "curves-active.png"), UIImage(named: "ton-active.png"),
                             UIImage(named: "exposure-active.png"), UIImage(named: "contrast-active.png"),
                             UIImage(named: "shadow-active.png"), UIImage(named: "highlights1-active.png"),
                             UIImage(named: "saturation1-active.png"), UIImage(named: "grain-active.png"),
                             UIImage(named: "temperature-active.png"), UIImage(named: "sharpen-active.png"),
                             UIImage(named: "strighten-active.png"), UIImage(named: "crop-active.png"),
                             UIImage(named: "clear-edit-active.png")]
    
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
            if (filterEffect.filterName == "CITemperatureAndTint") {
                currentFilter.setValue(CIVector(x:3000.0, y:0.0), forKey: "inputTargetNeutral")
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

    private func applyGrainTo1()-> UIImage? {
        var processedImage = self.image
        var noiseImage = self.image
        var randomScratches = self.image
        var darkScratches = self.image
        var speckledImage = self.image
        var sepiaCIImage = self.image
        var whiteSpecks = self.image
        let inputImage = self.image!
        let context = CIContext(options: nil)
        if let currentFilter = CIFilter(name: "CISepiaTone") {
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(1.0, forKey: "inputIntensity")
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    sepiaCIImage = UIImage(cgImage: cgimg)
                    // do something interesting with the processed image
                    
                }
            }
        }
        
        if let coloredNoise = CIFilter(name: "CIRandomGenerator") {
            if let output = coloredNoise.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    noiseImage = UIImage(cgImage: cgimg)
                }
            }
        }
        
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        let fineGrain = CIVector(x:0, y:0.005, z:0, w:0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        
        if let whiteningFilter = CIFilter(name: "CIColorMatrix") {
            let beginImage = CIImage(image: noiseImage!)
            whiteningFilter.setValue(beginImage, forKey: kCIInputImageKey)
            whiteningFilter.setValue(whitenVector, forKey: "inputRVector")
            whiteningFilter.setValue(whitenVector, forKey: "inputGVector")
            whiteningFilter.setValue(whitenVector, forKey: "inputBVector")
            whiteningFilter.setValue(fineGrain, forKey: "inputAVector")
            whiteningFilter.setValue(zeroVector, forKey: "inputBiasVector")

            if let output = whiteningFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    whiteSpecks = UIImage(cgImage: cgimg)
                }
            }
        }

        if let whiteningFilter = CIFilter(name: "CISourceOverCompositing") {

            whiteningFilter.setValue(whiteSpecks, forKey: kCIInputImageKey)
            whiteningFilter.setValue(sepiaCIImage, forKey: "inputBackgroundImage")

            if let output = whiteningFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    speckledImage = UIImage(cgImage: cgimg)
                }
            }
        }
        
        return speckledImage
    }
    private func applyGrainTo()-> UIImage? {
        var processedImage = self.image
        var noiseImage = self.image
        var randomScratches = self.image
        var darkScratches = self.image
        var speckledImage = self.image
        var sepiaCIImage = self.image
        var whiteSpecks = self.image
        let inputImage = self.image!
        
        if let currentFilter = CIFilter(name: "CISepiaTone") {
            let context = CIContext(options: nil)
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
                currentFilter.setValue(1.0, forKey: "inputIntensity")

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    sepiaCIImage = UIImage(cgImage: cgimg)
                    // do something interesting with the processed image
                    
                }
            }
        }
        
        if let coloredNoise = CIFilter(name: "CIRandomGenerator") {
            let context = CIContext(options: nil)
            if let output = coloredNoise.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    noiseImage = UIImage(cgImage: cgimg)
                }
            }
        }
        
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        let fineGrain = CIVector(x:0, y:0.005, z:0, w:0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        
        if let whiteningFilter = CIFilter(name: "CIColorMatrix") {
            let context = CIContext(options: nil)
            let beginImage = CIImage(image: noiseImage!)
            whiteningFilter.setValue(beginImage, forKey: kCIInputImageKey)
            whiteningFilter.setValue(whitenVector, forKey: "inputRVector")
            whiteningFilter.setValue(whitenVector, forKey: "inputGVector")
            whiteningFilter.setValue(whitenVector, forKey: "inputBVector")
            whiteningFilter.setValue(fineGrain, forKey: "inputAVector")
            whiteningFilter.setValue(zeroVector, forKey: "inputBiasVector")
            
            if let output = whiteningFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    whiteSpecks = UIImage(cgImage: cgimg)
                }
            }
        }

        if let whiteningFilter = CIFilter(name: "CISourceOverCompositing") {
            let context = CIContext(options: nil)
            whiteningFilter.setValue(whiteSpecks, forKey: kCIInputImageKey)
            whiteningFilter.setValue(sepiaCIImage, forKey: kCIInputBackgroundImageKey)

            if let output = whiteningFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    speckledImage = UIImage(cgImage: cgimg)
                }
            }
        }
        
        let darkenVector = CIVector(x: 4, y: 0, z: 0, w: 0)
        let darkenBias = CIVector(x: 0, y: 1, z: 1, w: 1)
        
        if let darkeningFilter = CIFilter(name: "CIColorMatrix") {
            let context = CIContext(options: nil)
            
             darkeningFilter.setValue(noiseImage, forKey: kCIInputImageKey)
             darkeningFilter.setValue(darkenVector, forKey: "inputRVector")
             darkeningFilter.setValue(zeroVector, forKey: "inputGVector")
             darkeningFilter.setValue(zeroVector, forKey: "inputBVector")
             darkeningFilter.setValue(zeroVector, forKey: "inputAVector")
             darkeningFilter.setValue(darkenBias, forKey: "inputBiasVector")
            
            if let output = darkeningFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    randomScratches = UIImage(cgImage: cgimg)
                }
            }
        }
        
        if let grayscaleFilter = CIFilter(name: "grayscaleFilter") {
            let context = CIContext(options: nil)
            
            grayscaleFilter.setValue(randomScratches, forKey: kCIInputImageKey)
            
            if let output = grayscaleFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    darkScratches = UIImage(cgImage: cgimg)
                }
            }
        }

        if let oldFilmCompositor = CIFilter(name: "CIMultiplyCompositing") {
            let context = CIContext(options: nil)
            
            oldFilmCompositor.setValue(darkScratches, forKey: kCIInputImageKey)
            oldFilmCompositor.setValue(whiteSpecks, forKey: kCIInputBackgroundImageKey)
            
            if let output = oldFilmCompositor.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    processedImage = UIImage(cgImage: cgimg)
                }
            }
        }
        
        return processedImage
    }
    

}


extension  AdjustViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        self.filterCollectionView.register(UINib.init(nibName: "AdjustCell", bundle: nil), forCellWithReuseIdentifier: "AdjustCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdjustCell", for: indexPath) as! AdjustCell

        print(cell)
        print(indexPath)
        
        cell.img.addConstraint(NSLayoutConstraint(item: cell.img, attribute: .height, relatedBy: .equal, toItem: cell.img, attribute: .width, multiplier: 16.0 / 16.0, constant: 0
        ))

        cell.imgCover.layer.sublayers?.removeAll()
        
        if (indexPath.row != self.adjustActiveNo) {
            cell.img.image = self.adjustArray[indexPath.row]
            cell.name.text = adjustNameArray[indexPath.row]
            cell.name.textColor = UIColorFromRGB(rgbValue: 0xffffff)
            cell.name.font = UIFont.systemFont(ofSize: 9)
            cell.imgCover.layer.borderWidth = CGFloat(1.0)
            cell.imgCover.layer.borderColor = UIColorFromRGB(rgbValue: 0xc6c6c6).cgColor
            cell.imgCover.layer.cornerRadius = cell.frame.size.width * 0.1
 
            
        }
        else {
            cell.img.image = self.adjustActiveArray[indexPath.row]
            cell.name.text = adjustNameArray[indexPath.row]
            cell.name.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
            cell.name.font = UIFont.boldSystemFont(ofSize: 9)
            cell.imgCover.layer.borderWidth = CGFloat(0.0)

            cell.imgCover.layer.masksToBounds = true
            cell.imgCover.layer.cornerRadius = cell.frame.size.width * 0.1
            cell.imgCover.layer.sublayers?.removeAll()
            let gradient = CAGradientLayer()
            gradient.frame =  cell.imgCover.bounds
            gradient.colors = [UIColorFromRGB(rgbValue: 0x28e8f3).cgColor, UIColorFromRGB(rgbValue: 0xfc4cfd).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            
            let shape = CAShapeLayer()
            shape.lineWidth = 4
            shape.path = UIBezierPath(roundedRect: cell.imgCover.bounds, cornerRadius: cell.frame.size.width * 0.1).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradient.mask = shape
            
            cell.imgCover.layer.insertSublayer(gradient, at: 0)

            

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.adjustArray.count
    
    }
    
}

extension AdjustViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 0.0
        height = Double(filterCollectionView.frame.height * 1)
        return CGSize(width: height * 0.7, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            self.adjustActiveNo = indexPath.row
        if (indexPath.row == 0) {
            NotificationCenter.default.post(name: Notification.Name("curve"), object: nil)
        }
        else if (indexPath.row == 1) {
            NotificationCenter.default.post(name: Notification.Name("tone"), object: nil)
        }
        else if (indexPath.row == self.adjustArray.count - 1) {
//            NotificationCenter.default.post(name: Notification.Name("payment"), object: nil)
        }
        else if (indexPath.row == 7) {
//            self.selectedImage.image = applyGrainTo()
        }
        else {
            guard let image = self.image else {
                return
            }
            self.selectedImage.image = applyFilterTo(image: image, filterEffect: filters[indexPath.row])
        }
            self.sliderView.isHidden = false
//            let heiConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 56.0)
//            self.sliderView.addConstraint(heiConstraint)
            filterCollectionView.reloadData()
       
    }
    
    
}

enum Direction {
    case horizontal
    case vertical
}

class View: UIView {
    
    init(frame: CGRect, cornerRadius: CGFloat, colors: [UIColor], lineWidth: CGFloat = 5, direction: Direction = .horizontal) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors = colors.map({ (color) -> CGColor in
            color.cgColor
        })
        
        switch direction {
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        case .vertical:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
        }
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: lineWidth,
                                                                   dy: lineWidth), cornerRadius: cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
