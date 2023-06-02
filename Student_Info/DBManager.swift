//
//  DBManager.swift
//  Student_Info
//
//  Created by ヴィヤヴャハレ・アディティア on 01/06/23.
//

import Foundation
import SQLite3

class DBManager
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS student(profilePicture TEXT, fullName TEXT, email TEXT, studentContact INTEGER, parentContact INTEGER, urn INTEGER PRIMARY KEY, class_Division TEXT, residentialAddress TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("table created.")
            } else {
                print("table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(profilePicture: String, fullName: String, email: String, studentContact: Int, parentContact: Int, URN: Int, class_Division: String, residentialAddress: String)
    {
        let insertStatementString = "INSERT INTO student(profilePicture, fullName, email, studentContact, parentContact, urn, class_Division, residentialAddress) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            //sqlite3_bind_int(insertStatement, 1, Int32(Id))
            sqlite3_bind_text(insertStatement, 1, (profilePicture as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (fullName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 4, Int32(studentContact))
            sqlite3_bind_int(insertStatement, 5, Int32(parentContact))
            sqlite3_bind_int(insertStatement, 6, Int32(URN))
            sqlite3_bind_text(insertStatement, 7, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (residentialAddress as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Student] {
        let queryStatementString = "SELECT * FROM student;"
        var queryStatement: OpaquePointer? = nil
        var readArray : [Student] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                //let id = sqlite3_column_int(queryStatement, 0)
                let profilePicture = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let fullName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let studentContact = sqlite3_column_int(queryStatement, 3)
                let parentContact = sqlite3_column_int(queryStatement, 4)
                let urn = sqlite3_column_int(queryStatement, 5)
                let class_Division = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let residentialAddress = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                
                readArray.append(Student(profilePicture: profilePicture, fullName: fullName, email: email, studentContact: Int(studentContact), parentContact: Int(parentContact), URN: Int(urn), class_Division: class_Division, residentialAddress: residentialAddress))
                
                //print("Query Result:")
                //print("\(profilePicture) | \(fullName) | \(email) | \(studentContact) | \(parentContact) | \(urn) | \(class_Division) | \(residentialAddress)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return readArray
    }
}
