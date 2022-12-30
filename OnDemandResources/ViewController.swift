//
//  ViewController.swift
//  OnDemandResources
//
//  Created by Raman Kozar on 30/12/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    var initialAssets = NSBundleResourceRequest(tags: ["Initial"])
    var photoTwoAssets: NSBundleResourceRequest? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshScreen()
        self.loadOnDemandAssets()
        
    }

    // Loading the second pic!
    @IBAction func loadPictures(_ sender: Any) {
        
        if photoTwoAssets != nil {
            photoTwoAssets?.endAccessingResources()
            photoTwoAssets = nil
        }
        
        photoTwoAssets = NSBundleResourceRequest(tags: ["Pic2"])
        
        photoTwoAssets?.conditionallyBeginAccessingResources(completionHandler: {[weak self] (state) in
            
            guard state == false else {
                DispatchQueue.main.async {
                    self?.refreshScreen()
                }
                return
            }
            
            self?.photoTwoAssets?.beginAccessingResources(completionHandler: {[weak self](error) in
                
                if let _ = error {
                    return
                }
                DispatchQueue.main.async {
                    self?.refreshScreen()
                }
                
            })
        })
        
    }
    
    func refreshScreen() {
        
        imageView1.image = UIImage(named: "pic1")
        imageView2.image = UIImage(named: "pic2")
        
    }
    
    func loadOnDemandAssets() {
        
        initialAssets.beginAccessingResources(completionHandler: { [weak self](error) in
            
            if let _ = error {
                return
            }
            DispatchQueue.main.async {
                self?.refreshScreen()
            }
            
        })
        
    }
    
    func finishUsingOnDemandAssets() {
        
        initialAssets.endAccessingResources()
        photoTwoAssets?.endAccessingResources()
        photoTwoAssets = nil
        
    }
    
}

