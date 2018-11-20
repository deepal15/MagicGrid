//
//  ViewController.swift
//  MagicGrid
//
//  Created by Deepal Patel on 20/11/18.
//  Copyright © 2018 Deepal Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let noOfCell = 15
    let cellWidth = UIScreen.main.bounds.width / CGFloat(15)
    var dic = [String : UIView]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for y in 0...100 {
            
            for x in 0...noOfCell {
                
                let cell = UIView()
                cell.frame = CGRect(x: CGFloat(x) * cellWidth, y: CGFloat(y) * cellWidth, width: cellWidth, height: cellWidth)
                cell.backgroundColor = UIColor.randomColor()
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(animateViews(gesture:))))
                let key = "\(y)|\(x)"
                dic[key] = cell
                self.view.addSubview(cell)
            }
        }
    }
    
    var selectedCell: UIView?
    
    @objc
    private func animateViews(gesture: UIPanGestureRecognizer) -> Swift.Void {
    
        let point = gesture.location(in: self.view)
        let x = Int(point.x / cellWidth)
        let y = Int(point.y / cellWidth)
        let key = "\(y)|\(x)"

        if let cell = dic[key] {
            
            if cell != self.selectedCell || gesture.state == .ended {
                
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    if let cellView = self.selectedCell { cellView.layer.transform = CATransform3DIdentity }
                }, completion: nil)
            }
        
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                cell.layer.transform = CATransform3DMakeScale(3, 3, 3)
            }, completion: nil)
            
            self.selectedCell = cell
        }
    }
}

extension UIColor {
    
    fileprivate static func randomColor() -> UIColor {
        
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        return .init(red: red, green: green, blue: blue, alpha: 1)
    }
}

