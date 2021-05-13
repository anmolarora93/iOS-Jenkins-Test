//
//  EditImageViewController.swift
//  Image Picker
//
//  Created by anmol on 17/04/21.
//

import UIKit

class EditImageViewController: UIViewController {
    @IBOutlet weak var selectedImageView: UIImageView?
    
    @IBAction func cancelEditingButtonPressed(_ sender: UIButton?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cropImageButttonPressed(_ sender: UIButton?) {
        
    }

    @IBAction func addEmojiBUttonPressed(_ sender: UIButton?) {
        
    }
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedImageView?.image = selectedImage
    }

}
