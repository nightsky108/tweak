//
//  FilterViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    var filterActiveNo = 100
    var imageArray = [UIImage]()
    var image : UIImage?
    
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


extension  FilterViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        if (indexPath.row != self.filterActiveNo) {
            cell.img.image = self.filterImage
        }
        else {
            cell.img.image = self.filterImageActive
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.filterArray.count
        
    }
    
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 0.0
        height = Double(filterCollectionView.frame.height * 0.8)
        return CGSize(width: height * 0.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.filterActiveNo = indexPath.row
        
        
        //            let heiConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 56.0)
        //            self.sliderView.addConstraint(heiConstraint)
        filterCollectionView.reloadData()
        
    }
    
    
}
