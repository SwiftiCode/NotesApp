//
//  Notes.swift
//  NotesApp
//
//  Created by Thomas.Tay.sg on 15/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import Foundation
import os.log

class Notes: NSObject, NSCoding {
    static var supportsSecureCoding: Bool = false
    
    
    // MARK: Types
    struct PropertyKey {
        static let titleKey = "title"
        static let noteKey = "note"
    }
    
    // MARK: Properties
    var title: String
    var notes: String
    
    // MARK: ArchiveURL
    static let DocDir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocDir.appendingPathComponent("notesmalpha1")
    
    // MARK: Initialization
    init(title:String, notes:String) {
        
        self.title = title
        self.notes = notes
        
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(title, forKey: PropertyKey.titleKey)
        aCoder.encode(notes, forKey: PropertyKey.noteKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //let myTtitle = aDecoder.decodeObject(forKey: PropertyKey.titleKey) as! String
        //let myNote = aDecoder.decodeObject(forKey: PropertyKey.noteKey) as! String
        guard let myNotesTitle = aDecoder.decodeObject(forKey: PropertyKey.titleKey) as? String else {
            os_log("Unable to decode the title for Notes.", log: OSLog.default, type: .debug)
            return nil
        }
        let myNotes = aDecoder.decodeObject(forKey: PropertyKey.noteKey) as! String
        
        self.init(title: myNotesTitle, notes: myNotes)
    }
    
}
