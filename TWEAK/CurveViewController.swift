//
//  CurveViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class CurveViewController: UIViewController {

    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var blueImg: UIImageView!
    @IBOutlet weak var greenImg: UIImageView!
    @IBOutlet weak var redImg: UIImageView!
    @IBOutlet weak var rgbImg: UIImageView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var rgbButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    var image : UIImage?
    
    var rgbIcon = UIImage(named: "rgb.png")
    var rgbIconActive = UIImage(named: "rgb-active.png")
    var redIcon = UIImage(named: "red.png")
    var redIconActive = UIImage(named: "red-active.png")
    var greenIcon = UIImage(named: "green.png")
    var greenIconActive = UIImage(named: "green-active.png")
    var blueIcon = UIImage(named: "blue.png")
    var blueIconActive = UIImage(named: "blue-active.png")
    var removeImage = UIImage(named: "remove.png")
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func blueProcess(_ sender: Any) {
        rgbImg.image = rgbIcon
        redImg.image = redIcon
        greenImg.image = greenIcon
        blueImg.image = blueIconActive
        rgbLabel.textColor = UIColor.white
        redLabel.textColor = UIColor.white
        greenLabel.textColor = UIColor.white
        blueLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
    }
    @IBAction func greenProcess(_ sender: Any) {
        rgbImg.image = rgbIcon
        redImg.image = redIcon
        greenImg.image = greenIconActive
        blueImg.image = blueIcon
        rgbLabel.textColor = UIColor.white
        redLabel.textColor = UIColor.white
        greenLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
        blueLabel.textColor = UIColor.white
    }
    @IBAction func redProcess(_ sender: Any) {
        rgbImg.image = rgbIcon
        redImg.image = redIconActive
        greenImg.image = greenIcon
        blueImg.image = blueIcon
        rgbLabel.textColor = UIColor.white
        redLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
        greenLabel.textColor = UIColor.white
        blueLabel.textColor = UIColor.white
    }
    @IBAction func rgbProcess(_ sender: Any) {
        rgbImg.image = rgbIconActive
        redImg.image = redIcon
        greenImg.image = greenIcon
        blueImg.image = blueIcon
        rgbLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
        redLabel.textColor = UIColor.white
        greenLabel.textColor = UIColor.white
        blueLabel.textColor = UIColor.white
    }
    @IBAction func done(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("adjust"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedImage.image = self.image

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
