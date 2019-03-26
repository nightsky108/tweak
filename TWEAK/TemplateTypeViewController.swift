//
//  TemplateTypeViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class TemplateTypeViewController: UIViewController {

    @IBOutlet weak var selectedImage: UIImageView!
    var image : UIImage?
    @IBAction func dismiss(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("template"), object: nil)
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
