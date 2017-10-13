//
//  AddNewRecipeViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit
import CoreData

class AddNewRecipeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textFieldNewName: UITextField!
    
    var newRecipeDetail:String?
    var brandName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    /* Core Data 사용을 위한 함수 */
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /* 키보드에 대한 delegate 함수 */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /* text field를 다 입력하지 않았을 경우 */
        if textFieldNewName.text == "" {
            let dialog = UIAlertController(title: "오류", message: "새로운 이름을 입력해주세요.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            
            self.present(dialog, animated: true, completion: nil)
        }
            /* 이름을 입력했을 경우 -> core data에 저장하고 최종레시피가 뜨는 화면으로 돌아가기 */
        else {
            let context = getContext()
            do {
                if let brand = brandName, let recipeDetail = newRecipeDetail {
                    let newRecipes = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context)
                    newRecipes.setValue(brand, forKey: "brand")
                    newRecipes.setValue(textFieldNewName.text, forKey: "menuName")
                    newRecipes.setValue(recipeDetail, forKey: "detailMenu")
                }
                
                try context.save()
                print("Success Saving1")
            }
            catch {
                //Error 발생시
                print("Fail Saving")
            }
            if segue.identifier == "toNewNameFinal" {
                let destVC = segue.destination as! FinalRecipeViewController
                destVC.finalRecipeName = textFieldNewName.text
                destVC.finalDetailRecipe = newRecipeDetail
            }
        }
    }
}
