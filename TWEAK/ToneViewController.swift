//
//  ToneViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class ToneViewController: UIViewController {

    @IBOutlet weak var luminance: UIImageView!
    @IBOutlet weak var saturationImg: UIImageView!
    @IBOutlet weak var hueImg: UIImageView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var btnRange: UIView!
    @IBOutlet weak var saturationRange: UIView!
    @IBOutlet weak var luminanceRange: UIView!
    
    
    var image : UIImage?
    @IBAction func done(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("adjust"), object: nil)
    }
    
    @IBOutlet weak var done: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedImage.image = self.image
        
        btnRange.layer.borderWidth = CGFloat(1.0)
        btnRange.layer.borderColor = UIColorFromRGB(rgbValue: 0x8e8e93).cgColor
        btnRange.layer.cornerRadius = btnRange.frame.size.width * 0.2
        
        saturationRange.layer.borderWidth = CGFloat(1.0)
        saturationRange.layer.borderColor = UIColorFromRGB(rgbValue: 0x8e8e93).cgColor
        saturationRange.layer.cornerRadius = btnRange.frame.size.width * 0.2
        
        luminanceRange.layer.borderWidth = CGFloat(1.0)
        luminanceRange.layer.borderColor = UIColorFromRGB(rgbValue: 0x8e8e93).cgColor
        luminanceRange.layer.cornerRadius = btnRange.frame.size.width * 0.2

        // Do any additional setup after loading the view.
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
