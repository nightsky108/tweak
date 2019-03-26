//
//  ToneViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class ToneViewController: UIViewController {

    @IBOutlet weak var selectedImage: UIImageView!
    var image : UIImage?
    @IBAction func done(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("adjust"), object: nil)
    }
    
    @IBOutlet weak var done: UIButton!
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
