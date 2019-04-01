//
//  RootViewController.swift
//  TWEAK
//
//  Created by ujs on 3/18/19.
//  Copyright © 2019 yg. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var adjustLabel: UILabel!
    @IBOutlet weak var canvasLabel: UILabel!
    @IBOutlet weak var templateLabel: UILabel!
    @IBOutlet weak var templateImg: UIImageView!
    @IBOutlet weak var canvasImg: UIImageView!
    @IBOutlet weak var adjustImg: UIImageView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var templateButton: UIButton!
    @IBOutlet weak var canvasButton: UIButton!
    @IBOutlet weak var adjustButton: UIButton!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    //    @IBOutlet weak var selectedImage: UIImageView!
    var adjustActiveNo = 100
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
    
    
    @IBAction func filterAction(_ sender: Any) {
        self.currrentMenuState = "filter"

        filterImg.image = filterIconActive
        adjustImg.image = adjustIcon
        canvasImg.image = canvasIcon
        templateImg.image = templateIcon
        
        filterLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
        adjustLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        templateLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        canvasLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        
        filterViewController.view.isHidden = false
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
       
    }
    
    @IBAction func templateAction(_ sender: Any) {
        self.currrentMenuState = "template"
        
        filterImg.image = filterIcon
        adjustImg.image = adjustIcon
        canvasImg.image = canvasIcon
        templateImg.image = templateIconActive
        
        filterLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        adjustLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        templateLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
        canvasLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = false
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
    }
    
    @IBAction func adjustAction(_ sender: Any) {
        self.currrentMenuState = "adjust"
        
        filterImg.image = filterIcon
        adjustImg.image = adjustIconActive
        canvasImg.image = canvasIcon
        templateImg.image = templateIcon
        
        filterLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        adjustLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
        templateLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        canvasLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = false
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
       
    }
    
    @IBAction func canvasAction(_ sender: Any) {
        self.currrentMenuState = "canvas"
        
        filterImg.image = filterIcon
        adjustImg.image = adjustIcon
        canvasImg.image = canvasIconActive
        templateImg.image = templateIcon
        filterLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        adjustLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        templateLabel.textColor = UIColorFromRGB(rgbValue: 0xc6c6c6)
        canvasLabel.textColor = UIColorFromRGB(rgbValue: 0x28e8f3)
        
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = false
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    lazy var filterViewController: FilterViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var adjustViewController: AdjustViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AdjustViewController") as! AdjustViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var canvasViewController: CanvasViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CanvasViewController") as! CanvasViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var templateViewController: TemplateViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TemplateViewController") as! TemplateViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var curveViewController: CurveViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CurveViewController") as! CurveViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var toneViewController: ToneViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ToneViewController") as! ToneViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var templateTypeViewController: TemplateTypeViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TemplateTypeViewController") as! TemplateTypeViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var templateColorViewController: TemplateColorViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TemplateColorViewController") as! TemplateColorViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var templateTextViewController: TemplateTextViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TemplateTextViewController") as! TemplateTextViewController
        viewController.image = self.image
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterViewController.view.isHidden = false
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
        templateTextViewController.view.isHidden = true
    
        NotificationCenter.default.addObserver(self, selector: #selector(displayCurve), name: Notification.Name("curve"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayTone), name: Notification.Name("tone"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayTemplateType), name: Notification.Name("templateType"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayTemplateColor), name: Notification.Name("templateColor"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayTemplateText), name: Notification.Name("templateText"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayAdjust), name: Notification.Name("adjust"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayTemplate), name: Notification.Name("template"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayPayment), name: Notification.Name("payment"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayHome), name: Notification.Name("home"), object: nil)
        
        // Do any additional setup after loading the view.
    }

    @objc func displayPayment(notification: NSNotification) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let payment = main.instantiateViewController(withIdentifier: "PaymentViewController")
        self.present(payment, animated: true, completion: nil)
    }
    
    @objc func displayHome(notification: NSNotification) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let payment = main.instantiateViewController(withIdentifier: "ViewController")
        self.present(payment, animated: true, completion: nil)
    }
    
    @objc func displayAdjust(notification: NSNotification) {
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = false
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
        templateTextViewController.view.isHidden = true
    }
    
    @objc func displayTemplate(notification: NSNotification) {
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = false
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
        templateTextViewController.view.isHidden = true
    }
    
    @objc func displayCurve(notification: NSNotification) {
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = false
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
        templateTextViewController.view.isHidden = true
    }
    
    @objc func displayTone(notification: NSNotification) {
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = false
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
        templateTextViewController.view.isHidden = true
    }
    
    @objc func displayTemplateType(notification: NSNotification) {
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = false
        templateColorViewController.view.isHidden = true
        templateTextViewController.view.isHidden = true
    }
    
    @objc func displayTemplateColor(notification: NSNotification) {
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = false
        templateTextViewController.view.isHidden = true
    }
    
    @objc func displayTemplateText(notification: NSNotification) {
        filterViewController.view.isHidden = true
        adjustViewController.view.isHidden = true
        canvasViewController.view.isHidden = true
        templateViewController.view.isHidden = true
        curveViewController.view.isHidden = true
        toneViewController.view.isHidden = true
        templateTypeViewController.view.isHidden = true
        templateColorViewController.view.isHidden = true
        templateTextViewController.view.isHidden = false
    }

    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
//        addViewControllerAsChildViewController(childViewController: childViewController)
        
        self.containerView.addSubview(childViewController.view)
        childViewController.view.frame = self.containerView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        childViewController.didMove(toParent: self)
        
    }
    
    private func removeViewControllerAsChildViewController(childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
}
