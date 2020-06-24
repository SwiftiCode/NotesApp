//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Thomas.Tay.sg on 15/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    // MARK: Properties
    var notesCollection = [Notes]()
    
    // MARK: Default Template
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if let gotSavedNotes = loadSavedNotes() {
            
            notesCollection += gotSavedNotes
            
        } else {
            
            loadSampleNotes()
        }
        
    
    }
    
    func loadSampleNotes() {
        
        let sample1 = Notes(title: "Sample1", notes: "Sample text 1")
        
        notesCollection += [sample1]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notesCollection.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "NotesTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NotesTableViewCell

        // Configure the cell...
        let localNote = notesCollection[indexPath.row]
        
        cell.cellNotesTitle.text = localNote.title
        
        cell.cellNotesTitle.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        //cell.cellNotesTitle.sizeToFit()
        //cell.cellNotesTitle.adjustsFontSizeToFitWidth = true
    
        


        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notesCollection.remove(at: indexPath.row)
            saveNote()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "EditNote" {
            
            let editNoteViewController = segue.destination as! NotesViewController
            if let selectedCell = sender as? NotesTableViewCell {
                let selectedIndexPath = tableView.indexPath(for: selectedCell)!
                let selectedNote = notesCollection[selectedIndexPath.row]
                editNoteViewController.currentNote = selectedNote
                
            }
        }
    }
    
    
    @IBAction func unwindToNoteList (_ unwindSegue: UIStoryboardSegue) {
        
        if let notesSourceViewController = unwindSegue.source as? NotesViewController, let noteToSave = notesSourceViewController.currentNote {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Edit Notes
                notesCollection[selectedIndexPath.row] = noteToSave
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
            
                // Add New Notes
                let newIndexPath = IndexPath(row: notesCollection.count, section: 0)
                notesCollection.append(noteToSave)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            
            saveNote()
        }
        
        
        
    }
    
    
    // MARK: NSCoding
    func saveNote() {
        
        let isGoodSave = NSKeyedArchiver.archiveRootObject(notesCollection, toFile: Notes.ArchiveURL.path)
        if !isGoodSave {
            print("Error Saving Files....")
        }
    }
    
    func loadSavedNotes() -> [Notes]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Notes.ArchiveURL.path) as? [Notes]
        
    }

}
