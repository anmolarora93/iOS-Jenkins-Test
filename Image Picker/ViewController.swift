//
//  ViewController.swift
//  Image Picker
//
//  Created by anmol on 13/04/21.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBAction func selectImageButtonPressed(_ sender: UIButton) {
        self.checkAndRequestForGalleryAccessPermission()
    }
    
    private var selectedImage: UIImage?
    private var selectedImageTitle: String?
    private var mainQueue = DispatchQueue.main

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func openImagePickerController() {
        self.setupAndPresentImagePickerController()
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowImageVC", let showImageVC = segue.destination as? ShowImageViewController {
            showImageVC.imageName = self.selectedImageTitle
            showImageVC.selectedImage = self.selectedImage
        }
    }
    
    private func prepareAndPresentGalleryAccessDeniedAlert() {
        let presentAccessDeniedAlertWorkItem = DispatchWorkItem() {
            let alert = UIAlertController(
                title: "We were unable to load your album groups. Sorry!",
                message: "You can enable access in Privacy Settings",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }))
            self.present(alert, animated: true)
        }
        mainQueue.async(execute: presentAccessDeniedAlertWorkItem)
    }
    
    private func prepareAndPresentImageEditorVC(on picker: UIImagePickerController) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let editImageVC = mainStoryboard.instantiateViewController(identifier: "EditImageViewController") as? EditImageViewController {
            editImageVC.selectedImage = self.selectedImage
            editImageVC.modalPresentationStyle = .overFullScreen
            picker.present(editImageVC, animated: true, completion: nil)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func setupAndPresentImagePickerController() {
        mainQueue.async {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.mediaTypes = ["public.image"]
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage, let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        self.selectedImage = image
        self.selectedImageTitle = fileUrl.lastPathComponent
        self.prepareAndPresentImageEditorVC(on: picker)
        //self.dismiss(animated: true, completion: nil)
    }
    
    func checkAndRequestForGalleryAccessPermission() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) {
            switch $0 {
            case .authorized, .limited:
                self.setupAndPresentImagePickerController()
            case .denied:
                self.prepareAndPresentGalleryAccessDeniedAlert()
            case .notDetermined:
                fatalError("Should Not Be Here!!!")
            default:
                print("Hehe")
            }
        }
    }
}

