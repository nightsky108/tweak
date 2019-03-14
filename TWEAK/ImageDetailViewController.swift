//
//  ImageDetailViewController.swift
//  TWEAK
//
//  Created by ujs on 3/6/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
   
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var templateButton: UIButton!
    @IBOutlet weak var canvasButton: UIButton!
    @IBOutlet weak var adjustButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
//    @IBOutlet weak var selectedImage: UIImageView!
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
    var shadowsIcon = UIImage(named: "shadows.png")
    
    @IBAction func fiterAction(_ sender: Any) {
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
        
        
//        self.selectedImage.image = self.image
        // Do any additional setup after loading the view.
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

extension  ImageDetailViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
            
            cell.filterName.text = "filter";
            if (self.currrentMenuState == "filter") {
                cell.img.image = self.imageArray[indexPath.row]
                cell.filterName.text = "filter"
            }
            else if (self.currrentMenuState == "adjust")
            {
                cell.img.image = self.image
                cell.filterName.text = "adjust"
            }
        
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
}

extension ImageDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = filterCollectionView.frame.height * 0.8
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    

}
