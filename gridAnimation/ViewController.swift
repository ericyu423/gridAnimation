//
//  ViewController.swift
//  gridAnimation
//
//  Created by eric yu on 5/2/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedcellV: UIView?
    var cells = [String: UIView]()//key,view
    var width: CGFloat {
        get {
            return view.frame.width * 0.05
        }
        set
        {
            displayBlocks()//rotation changes width
        }
    }
    
    var numViewPerRow: Int {
        return Int(view.frame.width / width)
    }
    
    var numViewPerColum: Int {
        return Int(view.frame.height / width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBlocks()
    }
    
    func displayBlocks(){
        
        for j in 0...numViewPerColum{
            for i in 0...numViewPerRow{
                let squareV = UIView()
                squareV.backgroundColor = randomColor()
                //squareV.frame = CGRect(x: CGFloat(i) * width, y:
                //  CGFloat(j) * width, width: width, height: width)
                squareV.layer.borderColor = UIColor.black.cgColor
                squareV.layer.borderWidth = 0.5
                view.addSubview(squareV)
                
                let key = "\(i)|\(j)"
                //cells[key] = squareV
                
                cells.updateValue(squareV, forKey: key)
                
                squareV.anchor(top:view.topAnchor, left: view.leftAnchor, bottom: nil,right: nil, paddingTop: CGFloat(j) * width, paddingLeft: CGFloat(i) * width, paddingBottom: 0, paddingRight: 0, width: width, height: width)
            }
        }

        /*
        if UIDevice.current.orientation.isLandscape {

        } else {
            
        }*/
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    
    func handlePanGesture(gesture: UIPanGestureRecognizer){
        let loc:CGPoint = gesture.location(in: view)
        
        let i = Int(loc.x / width)
        let j = Int(loc.y / width)
        
        let key = "\(i)|\(j)"
        guard let cellV = cells[key] else {return}
        
        if selectedcellV != cellV {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedcellV?.layer.transform = CATransform3DIdentity
            }, completion: nil)
            
        }
        
        selectedcellV = cellV
        view.bringSubview(toFront: cellV)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellV.layer.transform = CATransform3DMakeScale(3, 3, 3)
        },completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedcellV?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async() {
            self.width = self.view.bounds.size.width
        }
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

