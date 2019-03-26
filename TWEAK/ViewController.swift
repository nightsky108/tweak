//
//  ViewController.swift
//  TWEAK
//
//  Created by ujs on 3/5/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataArray = ["AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG","AAA", "BBB", "CCC", "DDD", "EEE", "FFF","AAA", "BBB", "CCC", "DDD", "EEE", "FFF","AAA", "BBB", "CCC", "DDD", "EEE", "FFF"]
    
    var cellMarginSize = 10.0
    var imageArray = [UIImage]()
    var selectedCellNo = IndexPath(row: 90, section: 0)
    @IBAction func gotoDetail(_ sender: Any) {
        performSegue(withIdentifier: "imageFilter", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RootViewController
        vc.imageArray = self.imageArray
        vc.image = self.imageArray[self.selectedCellNo.row]
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set Delegate
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
                                            contentMode: .aspectFit, options: requeestOptions, resultHandler: { (image, error) in self.imageArray.append(image!)
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

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
//        cell.setData(text: self.dataArray[indexPath.row])
        cell.layer.cornerRadius = cell.frame.width / 20.0
        cell.img.image = self.imageArray[indexPath.row]
  
        if (indexPath == self.selectedCellNo) {
//            let tintView = UIView()
//            tintView.backgroundColor = UIColor(white: 0, alpha: 0.8)
//            tintView.frame = CGRect(x: 0, y: 0, width: cell.img.frame.width, height: cell.img.frame.height)
//            cell.img.addSubview(tintView)


                cell.img.layer.masksToBounds = true
                cell.img.layer.borderWidth = CGFloat(7.0)
                cell.img.layer.borderColor = UIColor.red.cgColor



        }
        else {
//                let tintView1 = UIView()
//                tintView1.backgroundColor = UIColor(white: 0, alpha: 0.8)
//                tintView1.frame = CGRect(x: 0, y: 0, width: cell.img.frame.width, height: cell.img.frame.height)
//                cell.img.addSubview(tintView1)
                cell.img.layer.masksToBounds = true
                cell.img.layer.borderWidth = CGFloat(0.0)
                cell.img.layer.borderColor = UIColor.red.cgColor


        }

        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
//        let previousSell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: self.selectedCellNo) as! ItemCell
//
//        let tintView = UIView()
//        tintView.backgroundColor = UIColor(white: 0, alpha: 0.0)
//        tintView.frame = CGRect(x: 0, y: 0, width: previousSell.img.frame.width, height: previousSell.img.frame.height)
//        previousSell.img.addSubview(tintView)
//
//        previousSell.img.layer.masksToBounds = true
//        previousSell.img.layer.borderWidth = CGFloat(1.0)
//        previousSell.img.layer.borderColor = UIColor.red.cgColor
//
//
//            collectionView.reloadItems(at: [self.selectedCellNo])
        
//
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
//        tintView.backgroundColor = UIColor(white: 0, alpha: 0.9)
//        tintView.frame = CGRect(x: 0, y: 0, width: cell.img.frame.width, height: cell.img.frame.height)
//        cell.img.addSubview(tintView)
////
////        cell.img.layer.masksToBounds = true
//        cell.img.layer.borderWidth = CGFloat(7.0)
//        cell.img.layer.borderColor = UIColor.red.cgColor

        
        
        self.selectedCellNo = indexPath
        
//        collectionView.reloadItems(at: [indexPath])
        
        self.collectionView.reloadData()
        
        
        
       
        
        
    }
    
    func calculateWith() -> CGFloat {
        let cellcount = CGFloat(3)
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.collectionView.frame.size.width - CGFloat(cellMarginSize) * (cellcount - 1) - margin) / cellcount + CGFloat(self.cellMarginSize / 2)
        
//        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellcount - 1) - margin) / cellcount

        return width
    }
}
