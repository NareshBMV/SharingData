//
//  ViewController.swift
//  CollectionView
//
//  Created by Catie Catterwaul on 9/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var collectionData = ["Order", "Invoice", "Promo"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
    if let label = cell.viewWithTag(100) as? UILabel {
      label.text = collectionData[indexPath.row]
    }
    return cell
  }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.row == 0 {
            let vc = storyboard.instantiateViewController(withIdentifier: "orderCombine") as! CombineController
           self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = storyboard.instantiateViewController(withIdentifier: "invoice") as! InvoiceController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            let alert = UIAlertController(title: "Alert", message: "Promo is Disabled", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}













