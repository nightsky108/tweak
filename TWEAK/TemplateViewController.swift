//
//  TemplateViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class TemplateViewController: UIViewController {

    @IBAction func goToTemplateText(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("templateText"), object: nil)
    }
    
    @IBAction func goToTemplateColor(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("templateColor"), object: nil)
    }
    
    @IBAction func goToTemplateType(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("templateType"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
