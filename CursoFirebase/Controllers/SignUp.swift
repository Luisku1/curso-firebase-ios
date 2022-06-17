//
//  SignUp.swift
//  CursoFirebase
//
//  Created by UNAM FCA 17 on 17/06/22.
//

import UIKit

class SignUp: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    var selectedImage = false
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        imgProfileImage.layer.cornerRadius = imgProfileImage.frame.size.height / 2
        imgProfileImage.layer.borderWidth = 1
        imgProfileImage.layer.borderColor = UIColor.black.cgColor
        imgProfileImage.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        if let email = txtEmail.text, let name = txtName.text, let password = txtPassword.text, let confirmPassword = txtConfirmPassword.text
        {
            if !(email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty || !selectedImage)
            {
                if password == confirmPassword
                {
                    let credential = AuthCredential(name: name, email: email, password: password, image: imgProfileImage.image!)
                    
                    AuthService.registerUser(withCredentials: credential) { error in
                        
                        if error == nil
                        {
                            self.navigationController?.popViewController(animated: true)
                            
                        } else {
                            
                            print("DEBUG: - Signing Up \(error!.localizedDescription)")
                        }
                    }
                    
                        self.navigationController?.popViewController(animated: true)
                
                } else {
                    
                    print("DEBUG: - Passwords doesn't matchs")
                }
            
            } else {

                print("DEBUG: - A field is empty or didn't selected an image")
            }
        }
        
    }
    
    @IBAction func selectPicture(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Choose a source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true)
            }
            
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        self.present(alertController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let imageSelected = info[.originalImage] as? UIImage else { return }
        
        imgProfileImage.image = imageSelected.withRenderingMode(.alwaysOriginal)
        self.selectedImage = true
        
        dismiss(animated: true)
    }
}
