//
//  FirstScreenViewController.swift
//  TWEAK
//
//  Created by ujs on 3/9/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {

    @IBOutlet weak var slider: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.slider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(FirstScreenViewController.swipeLeft))
        recognizer.direction = .left
        self.view.addGestureRecognizer(recognizer)
     
        
    }
    
    @objc
    func swipeLeft() {
        print("left")
        let projectBrowser = ProjectBrowserViewController()
        navigationController?.pushViewController(projectBrowser, animated: true)
        
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
