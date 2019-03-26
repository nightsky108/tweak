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
    var selectedCellNo = IndexPath(row: 200, section: 0)
    
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
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        //        cell.setData(text: self.dataArray[indexPath.row])
        cell.layer.cornerRadius = cell.frame.width / 20.0
        cell.img.image = self.imageArray[indexPath.row]
        
        if (indexPath == self.selectedCellNo) {
            cell.img.layer.masksToBounds = true
            cell.img.layer.borderWidth = CGFloat(7.0)
            cell.img.layer.borderColor = UIColor.red.cgColor
            
            
            
        }
        else {
            cell.img.layer.masksToBounds = true
            cell.img.layer.borderWidth = CGFloat(0.0)
            cell.img.layer.borderColor = UIColor.red.cgColor
            
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
        self.selectedCellNo = indexPath
        self.collectionView.reloadData()
 
    }
    
    func calculateWith() -> CGFloat {
        let cellcount = CGFloat(2)
        
        let margin = CGFloat(self.cellMarginSize * 2)
        let width = (self.collectionView.frame.size.width - CGFloat(margin * (cellcount - 1))) / cellcount + CGFloat(self.cellMarginSize / 2)
        
        return width
    }
}
