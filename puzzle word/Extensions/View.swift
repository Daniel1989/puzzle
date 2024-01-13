//
//  View.swift
//  puzzle word
//
//  Created by Daniel on 2024/1/3.
//

import UIKit

let cellWidth = 30.0

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalWidth = cellWidth * Double(sudokuGrid.first!.count)
        let totalSpacingWidth = 0.0
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sudokuGrid[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCell", for: indexPath) as! UICollectionViewCell
        let item = UILabel(frame: cell.bounds)
        item.layer.borderColor = UIColor.gray.cgColor
        item.layer.borderWidth = 1.0
        
        item.text = sudokuGrid[indexPath.section][indexPath.row]
        if(item.text == "-") {
            item.backgroundColor = .black
        }
        item.textAlignment = .center
        cell.contentView.addSubview(item)
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sudokuGrid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedLetter = selectedLetter {
            sudokuGrid[indexPath.section][indexPath.row] = selectedLetter
            collectionView.reloadItems(at: [indexPath])
        }
    }
}
