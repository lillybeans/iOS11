//
//  ViewController.swift
//  Camera Roll
//
//  Created by Lilly Tong on 2017-10-17.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

//UINavigationControllerDelegate: allows us to jump from our app to other app
//UIImagePickerControllerDelegate: allows user to pick images

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate { 

    @IBOutlet var imageView: UIImageView!
    
    @IBAction func chooseImage(_ sender: Any) {
        
        //Open photo library and allow user to choose a image
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.allowsEditing = false //no editing images
        self.present(imagePickerController,animated:true,completion:nil) //do nothing when completed
        
    }
    
    //add image to image view once user has selected one
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image //set this to be our image
        } else {
            print("There was a problem in getting the image")
        }
        
        self.dismiss(animated: true, completion: nil) //do nothing when completed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

