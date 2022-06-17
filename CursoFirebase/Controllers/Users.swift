//
//  Users.swift
//  CursoFirebase
//
//  Created by UNAM FCA 17 on 17/06/22.
//

import UIKit

class Users: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usersTableView.delegate = self
        usersTableView.dataSource = self
        
        settingTable()
    }
    
    func settingTable()
    {
        UserService.getUsers { users in
            
            self.users = users
            self.usersTableView.reloadData()
        }
    }
}

extension Users : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        
        cell.userName.text = user.name
        
        if let imageData = try? Data(contentsOf: URL(string: user.image)!)
        {
            cell.imgProfileImage.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    
}
