//
//  HomeViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrOfInitials = [String]()
    var arrOfNames = [String]()
    
    var context:NSManagedObjectContext!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfInitials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Set Prototype Cells' Data (Initial and Name)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AssistantTableViewCell
        
        cell.initialTxt.text = arrOfInitials[indexPath.row]
        cell.nameTxt.text = arrOfNames[indexPath.row]
        
        cell.updateHandler = {
            self.updateData(cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    func updateData(cell: UITableViewCell, indexPath: IndexPath) {
        
    }
    
    @IBOutlet weak var assistantTv: UITableView!
    
    @IBOutlet weak var initialTxt: UITextField!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBAction func insertBtn(_ sender: Any) {
        // Get txt value
        // Create entity
        // Create new assistant
        // Save
        let name = nameTxt.text!
        let initial = initialTxt.text!
        
        let entity = NSEntityDescription.entity(forEntityName: "Assistants", in: context)
        
        let newAssistant = NSManagedObject(entity: entity!, insertInto: context)
        
        newAssistant.setValue(initial, forKey: "initial")
        newAssistant.setValue(name, forKey: "name")
        
        do {
            try context.save()
            loadData()
            
        } catch {
            print("Insert New Assistant failed")
        }
    }
    
    func loadData() {
        // Load Data based on existing array
        arrOfInitials.removeAll()
        arrOfNames.removeAll()
        
        // Select All and insert into array
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Assistants")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                arrOfInitials.append(data.value(forKey: "initial") as! String)
                arrOfNames.append(data.value(forKey: "name") as! String)
            }
            
            assistantTv.reloadData()
            
        } catch {
            print("Fetch data failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        assistantTv.delegate = self
        assistantTv.dataSource = self
        
        // Insert and Load data
        loadData()

        // Do any additional setup after loading the view.
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
