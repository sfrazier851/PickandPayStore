//
//  Department.swift
//  PickandPayStore
//
//  Created by iMac on 3/29/22.
//

import Foundation

struct Department {
    var id: Int = 0
    var name: String = ""
    var imageName: String = ""
    
    static let department = Department()
    
    // Convert query result set to Array of Department
    static func convert(departmentsResultSet: [[String]]) -> [Department]? {
        var departments = [Department]()
        for department_row in departmentsResultSet {
            let columns = department_row
            
            var department = Department()
            department.id = Int(columns[0])!
            department.name = columns[1]
            department.imageName = columns[2]
            
            departments.append(department)
        }
        return departments
    }
    
    static func getAll() -> [Department]? {
        return SQLiteDAL.getAllDepartments()
    }
    
    static func getByName(name: String) -> [Department]? {
        return SQLiteDAL.getDepartmentsByName(name: name)
    }
    
    static func create(name: String, imageName: String) -> Bool? {
        return SQLiteDAL.createDepartment(name: name, imageName: imageName)
    }
}
