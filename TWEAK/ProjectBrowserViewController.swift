//
//  ProjectBrowserViewController.swift
//  TWEAK
//
//  Created by ujs on 3/9/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit
import Photos

class ProjectBrowserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataArray = ["AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG","AAA", "BBB", "CCC", "DDD", "EEE", "FFF","AAA", "BBB", "CCC", "DDD", "EEE", "FFF","AAA", "BBB", "CCC", "DDD", "EEE", "FFF"]
    
    var cellMarginSize = 20.0
    var imageArray = [UIImage]()
    var selectedCellNo = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        //set Delegate
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //register cells
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        self.grabPhotos()
        
        //setup gridview
        self.setupGridView()
        
    }
    
    func grabPhotos() {
        imageArray = []
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager = PHImageManager.default()
            
            let requeestOptions = PHImageRequestOptions()
            requeestOptions.isSynchronous = true
            requeestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            print(fetchResult)
            print(fetchResult.count)
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: 300, height: 300),
                                            contentMode: .aspectFill, options: requeestOptions, resultHandler: { (image, error) in self.imageArray.append(image!)
                    })
                }
            } else {
                print("You got no pohotos.")
            }
            print("imageArrayCount: \(self.imageArray.count)")
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupGridView()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }

}

extension ProjectBrowserViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.collectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        cell.img.contentMode = .scaleAspectFill
        cell.img.layer.sublayers?.removeAll()
        
        if (indexPath.row != self.selectedCellNo) {
            cell.img.image = self.imageArray[indexPath.row]
            
            cell.img.layer.borderWidth = CGFloat(1.0)
            cell.img.layer.borderColor = UIColor.black.cgColor
            cell.img.layer.cornerRadius = cell.frame.width / 20.0
            cell.img.layer.masksToBounds = true
            cell.check.isHidden = true
            
        }
        else {
            cell.img.image = self.imageArray[indexPath.row]
            
            cell.check.isHidden = false
            let maskPath1 = UIBezierPath(roundedRect: cell.check.bounds,
                                         byRoundingCorners: [.bottomRight],
                                         cornerRadii: CGSize(width: cell.frame.width / 20.0, height: cell.frame.width / 20.0))
            let maskLayer1 = CAShapeLayer()
            maskLayer1.frame = cell.check.bounds
            maskLayer1.path = maskPath1.cgPath
            cell.check.layer.mask = maskLayer1
            
            cell.img.layer.masksToBounds = true
            cell.img.layer.borderWidth = CGFloat(0.0)
            cell.img.layer.cornerRadius = cell.frame.width / 20.0
            cell.img.layer.sublayers?.removeAll()
            let gradient = CAGradientLayer()
            gradient.frame =  cell.img.bounds
            gradient.colors = [UIColorFromRGB(rgbValue: 0x28e8f3).cgColor, UIColorFromRGB(rgbValue: 0xfc4cfd).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            
            let shape = CAShapeLayer()
            shape.lineWidth = 5
            shape.path = UIBezierPath(roundedRect: cell.img.bounds, cornerRadius: cell.frame.width / 20.0).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradient.mask = shape
            
            cell.img.layer.insertSublayer(gradient, at: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
        }
        
        return cell
        
    }
    
    
    
}

extension ProjectBrowserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        let height = CGFloat(width * 1.2)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        self.selectedCellNo = indexPath.row
        self.collectionView.reloadData()
 
    }
    
    func calculateWith() -> CGFloat {
        let cellcount = CGFloat(2)
        
        let margin = CGFloat(self.cellMarginSize * 2)
        let width = (self.collectionView.frame.size.width - CGFloat(margin * (cellcount - 1))) / cellcount + CGFloat(self.cellMarginSize / 2)
        
        return width
    }
}
