//
//  RegisterViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    // Application Context
    // Don't forget to import CoreData and don't forget !
    // var variable:datatype
    var context:NSManagedObjectContext!
    
    @IBAction func registerBtn(_ sender: Any) {
        // Get the value of TextField and store to Database
        
        // let -> unmutable
        // var -> mutable
        
        // as! String -> nullable
        let username = usernameTxt.text as! String
        let password = passwordTxt.text as! String
        
        // Create entity
        // Create new user
        // Insert new user
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        // forKey = attributes in DB
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do {
            try context.save()
            
            // Auto redirect to Login Page
            
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                navigationController?.pushViewController(nextView, animated: true)
            }
        }
        catch {
            print("Insert NewUser Failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext

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
