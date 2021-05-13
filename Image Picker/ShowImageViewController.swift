//
//  ShowImageViewController.swift
//  Image Picker
//
//  Created by anmol on 17/04/21.
//

import UIKit

class ShowImageViewController: UIViewController {
    
    @IBOutlet weak var selectedImageView: UIImageView?

    var selectedImage: UIImage?
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = imageName
        self.selectedImageView?.image = selectedImage
        self.selectedImageView?.contentMode = .scaleAspectFill
    }
}
