//
//  CombineController.swift
//  OrderApp
//
//  Created by Naresh on 02/05/20.
//  Copyright © 2020 Naresh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CombineController: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var shadowView: UIView!
    let blueInstagramColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = blueInstagramColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 18)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .darkGray
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.blueInstagramColor
        }
        super.viewDidLoad()
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "prodList") as! OrderController
        let vc2 = storyboard.instantiateViewController(withIdentifier: "prodSummary") as! ProductSummaryController
        let vc3 = storyboard.instantiateViewController(withIdentifier: "generateInvoice") as! GenerateInvoiceController

        return [vc1, vc2, vc3]
    }

    override func viewWillDisappear(_ animated: Bool) {
        SharedData.sharedInstance.selectedProducts.removeAll()
    }
    
}
