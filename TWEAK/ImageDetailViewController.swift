//
//  ImageDetailViewController.swift
//  TWEAK
//
//  Created by ujs on 3/6/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
   

    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var templateButton: UIButton!
    @IBOutlet weak var canvasButton: UIButton!
    @IBOutlet weak var adjustButton: UIButton!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
//    @IBOutlet weak var selectedImage: UIImageView!
    var adjustActiveNo = 100
    var imageArray = [UIImage]()
    var image : UIImage?
    var currrentMenuState = "filter"
    
    var filterIcon = UIImage(named: "filter.png")
    var filterIconActive = UIImage(named: "filter-active.png")
    var adjustIcon = UIImage(named: "adjust.png")
    var adjustIconActive = UIImage(named: "adjust-active.png")
    var canvasIcon = UIImage(named: "canvas.png")
    var canvasIconActive = UIImage(named: "canvas-active.png")
    var templateIcon = UIImage(named: "template.png")
    var templateIconActive = UIImage(named: "template-active.png")
    var removeImage = UIImage(named: "remove.png")
    
    var exposureIcon = UIImage(named: "exposure.png")
    var contrastIcon = UIImage(named: "contrast.png")
    var shadowsIcon = UIImage(named: "shadow.png")
    var highlightsIcon = UIImage(named: "highlights.png")
    var saturationIcon = UIImage(named: "saturation.png")
    var grainIcon = UIImage(named: "grain.png")
    var temperatureIcon = UIImage(named: "temperature.png")
    var sharpenIcon = UIImage(named: "sharpen.png")
    var straightenIcon = UIImage(named: "straighten.png")
    var cropIcon = UIImage(named: "crop.png")
    var clear_edit = UIImage(named: "clear_edit.png")
    
    var adjustArray = [UIImage(named: "curves.png"), UIImage(named: "tone.png"),
                       UIImage(named: "exposure.png"), UIImage(named: "contrast.png"),
                       UIImage(named: "shadow.png"), UIImage(named: "highlights.png"), UIImage(named: "saturation.png"), UIImage(named: "grain.png"), UIImage(named: "temperature.png"), UIImage(named: "sharpen.png"), UIImage(named: "straighten.png"), UIImage(named: "crop.png"), UIImage(named: "clear_edit.png")]
    
    var adjustActiveArray = [UIImage(named: "curves.png"), UIImage(named: "tone.png"),
                             UIImage(named: "exposure-active.png"), UIImage(named: "contrast-active.png"),
                             UIImage(named: "shadow-active.png"), UIImage(named: "highlights-active.png"),
                             UIImage(named: "saturation-active.png"), UIImage(named: "grain-active.png"),
                             UIImage(named: "temperature-active.png"), UIImage(named: "sharpen-active.png"),
                             UIImage(named: "straighten-active.png"), UIImage(named: "crop-active.png"),
                             UIImage(named: "clear_edit-active.png")]
    
    @IBAction func filterAction(_ sender: Any) {
        self.currrentMenuState = "filter"
        filterButton.setImage(filterIconActive, for: .normal)
        canvasButton.setImage(canvasIcon, for: .normal)
        adjustButton.setImage(adjustIcon, for: .normal)
        templateButton.setImage(templateIcon, for: .normal)
    
        self.filterCollectionView.reloadData()
    }
    
    @IBAction func templateAction(_ sender: Any) {
        self.currrentMenuState = "template"
        filterButton.setImage(filterIcon, for: .normal)
        canvasButton.setImage(canvasIcon, for: .normal)
        adjustButton.setImage(adjustIcon, for: .normal)
        templateButton.setImage(templateIconActive, for: .normal)
    }
    
    @IBAction func adjustAction(_ sender: Any) {
        self.currrentMenuState = "adjust"
        filterButton.setImage(filterIcon, for: .normal)
        canvasButton.setImage(canvasIcon, for: .normal)
        adjustButton.setImage(adjustIconActive, for: .normal)
        templateButton.setImage(templateIcon, for: .normal)
        self.filterCollectionView.reloadData()
    }
    
    @IBAction func canvasAction(_ sender: Any) {
        self.currrentMenuState = "canvas"
        filterButton.setImage(filterIcon, for: .normal)
        canvasButton.setImage(canvasIconActive, for: .normal)
        adjustButton.setImage(adjustIcon, for: .normal)
        templateButton.setImage(templateIcon, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
    }


}

extension  ImageDetailViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        self.filterCollectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            
//            cell.filterName.text = "filter";
            if (self.currrentMenuState == "filter") {
                cell.img.image = self.imageArray[indexPath.row]
//                cell.filterName.text = "filter"
            }
            else if (self.currrentMenuState == "adjust")
            {
                if (indexPath.row != self.adjustActiveNo) {
                    cell.img.image = self.adjustArray[indexPath.row]
                }
                else {
                    cell.img.image = self.adjustActiveArray[indexPath.row]
                }
                
//                cell.filterName.text = ""
                
            }
        
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0;
        if (self.currrentMenuState == "filter") {
            count = self.imageArray.count
        }
        else if (self.currrentMenuState == "adjust") {
            count = self.adjustArray.count
        }
        return count
    }
    
}

extension ImageDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 0.0
        if (self.currrentMenuState == "filter") {
            height = Double(filterCollectionView.frame.height * 0.8)
        }
        else {
            height = Double(filterCollectionView.frame.height * 0.8)
        }
        
        return CGSize(width: height * 0.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.currrentMenuState == "adjust") {
            self.adjustActiveNo = indexPath.row
            filterCollectionView.reloadData()
        }
    }
    

}
