//
//  TemplateTypeViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class TemplateTypeViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var templateTypeCollectionView: UICollectionView!
    @IBOutlet weak var selectedImage: UIImageView!
    var image : UIImage?
    
    var templateActiveNo = 0
    var imageArray = [UIImage]()
    var updatedImage : UIImage?
    var updatedImageForSave : UIImage?
    
//    var templateArray = [UIImage(named: "Classic-1.png"), UIImage(named: "Classic-2.png"),
//                       UIImage(named: "Classic-3.png"), UIImage(named: "Classic-4.png"),
//                       UIImage(named: "Classic-5.png"), UIImage(named: "Classic-6.png"), UIImage(named: "Classic-7.png"), UIImage(named: "Classic-8.png"), UIImage(named: "Classic-9.png"), UIImage(named: "Classic-10.png"), UIImage(named: "1-Film.png"), UIImage(named: "2-Film.png"), UIImage(named: "3-Film.png")]
    
    var templateArray = [UIImage(named: "1-Film.png"), UIImage(named: "2-Film.png"),
                         UIImage(named: "3-Film.png"), UIImage(named: "4-Film.png"),
                         UIImage(named: "5-Film.png"), UIImage(named: "6-Film.png"),
                         UIImage(named: "7-Film.png"), UIImage(named: "8-Film.png"),
                         UIImage(named: "9-Film.png"), UIImage(named: "10-Film.png"),
                         UIImage(named: "11-Film.png"), UIImage(named: "12-Film.png"),
                         UIImage(named: "13-Film.png"), UIImage(named: "14-Film.png"),
                         UIImage(named: "15-Film.png")]

    lazy var film1ViewController: Film1ViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "Film1ViewController") as! Film1ViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    @IBAction func dismiss(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("template"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.templateTypeCollectionView.delegate = self
        self.templateTypeCollectionView.dataSource = self
        film1ViewController.view.isHidden = false
       
        // Do any additional setup after loading the view.
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        //        addViewControllerAsChildViewController(childViewController: childViewController)
        
        self.containerView.addSubview(childViewController.view)
        childViewController.view.frame = self.containerView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //        childViewController.didMove(toParent: self)
        
    }
    
    private func removeViewControllerAsChildViewController(childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }

}

extension  TemplateTypeViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        self.templateTypeCollectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.backgroundColor = UIColor.white
        
        cell.img.contentMode = .scaleAspectFill
        cell.img.layer.sublayers?.removeAll()
        
        if (indexPath.row != self.templateActiveNo) {
            cell.img.image = self.templateArray[indexPath.row]
            
            cell.img.layer.borderWidth = CGFloat(1.0)
            cell.img.layer.borderColor = UIColor.black.cgColor
//            cell.img.layer.cornerRadius = cell.frame.size.width * 0.1
            cell.img.layer.masksToBounds = true
        }
        else {
            cell.img.image = self.templateArray[indexPath.row]
            cell.img.layer.masksToBounds = true
            cell.img.layer.borderWidth = CGFloat(0.0)
//            cell.img.layer.cornerRadius = cell.frame.size.width * 0.1
            cell.img.layer.sublayers?.removeAll()
            let gradient = CAGradientLayer()
            gradient.frame =  cell.img.bounds
            gradient.colors = [UIColorFromRGB(rgbValue: 0x28e8f3).cgColor, UIColorFromRGB(rgbValue: 0xfc4cfd).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            
            let shape = CAShapeLayer()
            shape.lineWidth = 5
            shape.path = UIBezierPath(roundedRect: cell.img.bounds, cornerRadius: cell.frame.size.width * 0.0).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradient.mask = shape
            
            cell.img.layer.insertSublayer(gradient, at: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.templateArray.count
        
    }
    
}

extension TemplateTypeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 0.0
        height = Double(templateTypeCollectionView.frame.height * 0.8)
        return CGSize(width: height * 0.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.templateActiveNo = indexPath.row
        
        if (indexPath.row == self.templateArray.count - 1) {
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
        templateTypeCollectionView.reloadData()
        
    }
    
    
}
