//
//  Student.swift
//  Student_Info
//
//  Created by ヴィヤヴャハレ・アディティア on 01/06/23.
//

import Foundation

class Student {
    //let Id: Int
    let profilePicture: String
    let fullName: String
    let email: String
    let studentContact: Int
    let parentContact: Int
    let URN: Int
    let class_Division: String
    let residentialAddress: String
    
    init(profilePicture: String, fullName: String, email: String, studentContact: Int, parentContact: Int, URN: Int, class_Division: String, residentialAddress: String) {
        //self.Id = Id
        self.profilePicture = profilePicture
        self.fullName = fullName
        self.email = email
        self.studentContact = studentContact
        self.parentContact = parentContact
        self.URN = URN
        self.class_Division = class_Division
        self.residentialAddress = residentialAddress
    }
}

