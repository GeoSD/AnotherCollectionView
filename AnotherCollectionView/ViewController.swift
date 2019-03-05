//
//  ViewController.swift
//  AnotherCollectionView
//
//  Created by Georgy Dyagilev on 05/03/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var visibleScale = [Int](repeating: 0, count: 221)
    var currentHeading = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateScale(heading: currentHeading)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleScale.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: IndexPath(row: indexPath.row, section: 0)) as! CollectionViewCell
        let indexPathRow = indexPath.row
        
        if (visibleScale[indexPathRow] * 2) % 90 == 0 {
            cell.heightConstraint.constant = 25
        } else if (visibleScale[indexPathRow] * 2) % 15 == 0 && (visibleScale[indexPathRow] * 2) % 90 != 0 {
            cell.heightConstraint.constant = 15
        } else {
            cell.heightConstraint.constant = 0
        }
        return cell
    }
    
    func updateScale(heading: Int) {

        let firstScaleItem = heading - 110

        if firstScaleItem >= -110 && firstScaleItem < 0 {
            var startHeading = 360 + firstScaleItem
            for index in 0...110 {
                visibleScale[index] = startHeading
                startHeading += 1
            }
            for index in 111...220 {
                visibleScale[index] = startHeading
                startHeading += 1
            }
            print(visibleScale.count)
            collectionView.reloadData()
            return
        }
        
        if firstScaleItem == 0 {
            for index in visibleScale.indices {
                visibleScale[index] = index
            }
            print(visibleScale.count)
            collectionView.reloadData()
            return
        }
        
        if firstScaleItem > 0 && firstScaleItem <= 249 {
            var startHeading = firstScaleItem
            for index in 0...220 {
                visibleScale[index] = startHeading
                startHeading += 1
            }
            print(visibleScale.count)
            collectionView.reloadData()
            return
        }
    }
    
    @IBAction func leftButton(_ sender: UIButton) {
        if currentHeading == 0 {
            currentHeading = 360 - 1
        } else {
            currentHeading -= 1
        }
        updateScale(heading: currentHeading)
    }
    
    @IBAction func rightButton(_ sender: UIButton) {
        if currentHeading == 359 {
            currentHeading = 0
        } else {
            currentHeading += 1
        }
        updateScale(heading: currentHeading)
    }
}
