//
//  ViewDetailsViewController.swift
//  Student_Info
//
//  Created by ヴィヤヴャハレ・アディティア on 31/05/23.
//

import UIKit

class ViewDetailsViewController: UIViewController {
    
    let db = DBManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    var students: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        students = db.read()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let TableViewCell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(TableViewCell, forCellReuseIdentifier: "CustomCell")
    }
}

extension ViewDetailsViewController: UITableViewDelegate {}

extension ViewDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewcell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! TableViewCell
        
        let imageBase64String = students[indexPath.row].profilePicture
        //print("image string retreived from DB: \(imageBase64String)")
        
        
        let newImageData = Data(base64Encoded: imageBase64String)
        
        
        tableViewcell.profilePictureImageView.image = UIImage(data: newImageData!)
        
        tableViewcell.fullNameLabel.text = "Full name: \(students[indexPath.row].fullName)"
        tableViewcell.emailLabel.text = "Email: \(students[indexPath.row].email)"
        tableViewcell.studentContactLabel.text = "Student no.: \(String(students[indexPath.row].studentContact))"
        tableViewcell.parentContactLabel.text = "Parent no.: \(String(students[indexPath.row].parentContact))"
        tableViewcell.urnLabel.text = "URN: \(String(students[indexPath.row].URN))"
        tableViewcell.class_divisionLabel.text = "Class & Division: \(students[indexPath.row].class_Division)"
        tableViewcell.residentialAddressLabel.text = "Residential address: \(students[indexPath.row].residentialAddress)"
        
        return tableViewcell
    }
    
    
}
