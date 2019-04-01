//
//  TemplateViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class TemplateViewController: UIViewController {

    @IBAction func gotoType(_ sender: Any) {
         NotificationCenter.default.post(name: Notification.Name("templateType"), object: nil)
    }
    @IBAction func gotoColors(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("templateColor"), object: nil)
    }
    @IBAction func gotoText(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("templateText"), object: nil)
    }
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var colorsLabel: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var textCover: UIView!
    @IBOutlet weak var textImg
    : UIImageView!
    @IBOutlet weak var colorsCover: UIView!
    @IBOutlet weak var colorsImg: UIImageView!
    @IBOutlet weak var templateType: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeCover: UIView!
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeCover.layer.borderWidth = CGFloat(1.0)
        typeCover.layer.borderColor = UIColorFromRGB(rgbValue: 0x8e8e93).cgColor
        typeCover.layer.cornerRadius = typeCover.frame.size.width * 0.2
        
//        typeCover.layer.sublayers?.removeAll()
//
//        typeCover.layer.masksToBounds = true
//        typeCover.layer.cornerRadius = typeCover.frame.size.width * 0.2
//
//        let gradient = CAGradientLayer()
//        gradient.frame =  CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: typeCover.frame.size.width, height: typeCover.frame.size.height))
//        gradient.colors = [UIColorFromRGB(rgbValue: 0x8e8e93).cgColor, UIColorFromRGB(rgbValue: 0x8e8e93).cgColor]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//
//        let shape = CAShapeLayer()
//        shape.lineWidth = 2
//        shape.path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: typeCover.frame.size.width * 1.0, height: typeCover.frame.size.height * 1.0)), cornerRadius: typeCover.frame.size.width * 0.2).cgPath
//        shape.strokeColor = UIColor.black.cgColor
//        shape.fillColor = UIColor.clear.cgColor
//        gradient.mask = shape
//
//
//
//        typeCover.layer.addSublayer(gradient)
        
        
        
        textCover.layer.borderWidth = CGFloat(1.0)
        textCover.layer.borderColor = UIColorFromRGB(rgbValue: 0x8e8e93).cgColor
        textCover.layer.cornerRadius = typeCover.frame.size.width * 0.2
        
        colorsCover.layer.borderWidth = CGFloat(1.0)
        colorsCover.layer.borderColor = UIColorFromRGB(rgbValue: 0x8e8e93).cgColor
        colorsCover.layer.cornerRadius = colorsCover.frame.size.width * 0.2

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
