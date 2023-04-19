//
//  LoginViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    @IBAction func loginBtn(_ sender: Any) {
        // Get data from textfield
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        
        // Request to CoreData
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        // Try to fetch data
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            // Login null or not, cek the size of array
            if result.count == 0 {
                print("Login Failed")
            } else {
                print("Login Successfull")
                
                // Redirect to Home Page
                if let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                    navigationController?.pushViewController(nextView, animated: true)
                }
            }
            
        } catch {
            print("Fetch data failed")
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
