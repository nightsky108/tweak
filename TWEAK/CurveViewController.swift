//
//  CurveViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class CurveViewController: UIViewController {

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
    
    @IBAction func blueProcess(_ sender: Any) {
        rgbButton.setImage(rgbIcon, for: .normal)
        redButton.setImage(redIcon, for: .normal)
        greenButton.setImage(greenIcon, for: .normal)
        blueButton.setImage(blueIconActive, for: .normal)
    }
    @IBAction func greenProcess(_ sender: Any) {
        rgbButton.setImage(rgbIcon, for: .normal)
        redButton.setImage(redIcon, for: .normal)
        greenButton.setImage(greenIconActive, for: .normal)
        blueButton.setImage(blueIcon, for: .normal)
    }
    @IBAction func redProcess(_ sender: Any) {
        rgbButton.setImage(rgbIcon, for: .normal)
        redButton.setImage(redIconActive, for: .normal)
        greenButton.setImage(greenIcon, for: .normal)
        blueButton.setImage(blueIcon, for: .normal)
    }
    @IBAction func rgbProcess(_ sender: Any) {
        rgbButton.setImage(rgbIconActive, for: .normal)
        redButton.setImage(redIcon, for: .normal)
        greenButton.setImage(greenIcon, for: .normal)
        blueButton.setImage(blueIcon, for: .normal)
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
