//
//  EnterDetailsViewController.swift
//  Student_Info
//
//  Created by ヴィヤヴャハレ・アディティア on 31/05/23.
//

import UIKit

class EnterDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let db = DBManager()
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var studentNumberTextField: UITextField!
    @IBOutlet weak var parentNumberTextField: UITextField!
    @IBOutlet weak var URNNumberTextField: UITextField!
    @IBOutlet weak var classDivisionTextField: UITextField!
    @IBOutlet weak var residentialAddressTextView: UITextView!
    
    @IBOutlet weak var saveButtonView: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var profilePicString: String = ""
    var fullName: String = ""
    var email: String = ""
    var studentContact: Int = 0
    var parentContact: Int = 0
    var urn: Int = 0
    var class_Division: String = ""
    var residentialAddress: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        profilePictureView.image = UIImage(named: "profilePicPlaceholder")
        profilePictureView.isUserInteractionEnabled = true
        profilePictureView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        
        saveButtonView.layer.cornerRadius = 15
        residentialAddressTextView.layer.borderColor = UIColor.separator.cgColor
        residentialAddressTextView.layer.cornerRadius = 10
        residentialAddressTextView.layer.borderWidth = 1
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        //print("image tapped")
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            profilePictureView.image = image
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        let imageData = profilePictureView.image?.jpegData(compressionQuality: 1)
        let imageBase64String = imageData?.base64EncodedString()
        
        
        /*let imageData:NSData = profilePictureView.image!.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)*/
        //print(strBase64)
        profilePicString = imageBase64String!
        fullName = fullNameTextField.text!
        email = emailTextField.text!
        studentContact = Int(studentNumberTextField.text!)!
        parentContact = Int(parentNumberTextField.text!)!
        urn = Int(URNNumberTextField.text!)!
        class_Division = classDivisionTextField.text!
        residentialAddress = residentialAddressTextView.text!
        
        
        db.insert(profilePicture: profilePicString, fullName: fullName, email: email, studentContact: studentContact, parentContact: parentContact, URN: urn, class_Division: class_Division, residentialAddress: residentialAddress)
        
        //database file path when running on simulator
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

        let docsDir = dirPaths[0]

        print("DB file path: \(docsDir)")
        
        profilePictureView.image = UIImage(named: "profilePicPlaceholder")
        fullNameTextField.text = ""
        emailTextField.text = ""
        studentNumberTextField.text = ""
        parentNumberTextField.text  = ""
        URNNumberTextField.text = ""
        classDivisionTextField.text = ""
        residentialAddressTextView.text = ""
    }
}
