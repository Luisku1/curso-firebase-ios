//
//  Profile.swift
//  CursoFirebase
//
//  Created by UNAM FCA 17 on 17/06/22.
//

import UIKit
import FirebaseAuth

class Profile: UIViewController {

    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgProfileImage.layer.cornerRadius = imgProfileImage.frame.size.height / 2
        imgProfileImage.layer.borderWidth = 1
        imgProfileImage.layer.borderColor = UIColor.black.cgColor
        imgProfileImage.clipsToBounds = true
        
        getUser()
    }
    
    func getUser()
    {
        UserService.getUser { user in
            
            self.lblName.text = user.name
            self.lblEmail.text = user.email
            
            if let imageData = try? Data(contentsOf: URL(string: user.image)!)
            {
                self.imgProfileImage.image = UIImage(data: imageData)
            }
        }
    }
    
    @IBAction func closeSession(_ sender: UIButton) {
        do
        {
            try Auth.auth().signOut()
            
        } catch {
            
            print("DEBUG: - Loging out Error")
        }
        
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
