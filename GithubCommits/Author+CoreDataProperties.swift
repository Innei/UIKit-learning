//
//  Author+CoreDataProperties.swift
//  GithubCommits
//
//  Created by Innei on 2021/2/28.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var commits: Commit?

}

extension Author : Identifiable {

}
