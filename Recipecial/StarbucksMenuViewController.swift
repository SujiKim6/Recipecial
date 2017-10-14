//
//  StarbucksMenuViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit
import CoreData

class StarbucksMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerStarMenu: UIPickerView!
    @IBOutlet var labelStarDetailRecipe: UILabel!
    
    var starMenuDictionary:[String:String] = [:] // picker에 들어갈 메뉴와 그 메뉴에 해당하는 레시피 저장
    var sortedKeys:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* 코어데이터에서 데이터를 빼서 starMenuDictionary에 추가하기 */
        let context = self.getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            for menuList in results as! [NSManagedObject] {
                if let brandName = menuList.value(forKey: "brand") as? String,
                    let recipeName = menuList.value(forKey: "menuName") as? String,
                    let detailRecipe = menuList.value(forKey: "detailMenu") as? String
                {
                    if brandName == "Starbucks" {
                        starMenuDictionary[recipeName] = detailRecipe
                    }
                }
            }
//            print(starMenuDictionary)
        } catch {
            print("Find error")
        }
        
        /* key 값만 추출하여 정렬 후 배열에 배정 */
        let unsortedKeys = Array(starMenuDictionary.keys)
        sortedKeys = unsortedKeys.sorted()
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
    
    /* custom picker에 들어갈 내용 */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortedKeys.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortedKeys[row]
    }
    
    /* picker에서 하나 선택 후 검색 버튼 눌렀을 시 라벨에 레시피 띄우기 */
    @IBAction func buttonSearch() {
        let index = pickerStarMenu.selectedRow(inComponent: 0)
        let key:String = sortedKeys[index]
        
        labelStarDetailRecipe.text = starMenuDictionary[key]
    }
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = pickerStarMenu.selectedRow(inComponent: 0)
        let key:String = sortedKeys[index]
        
        if labelStarDetailRecipe.text != "Detail Recipe" {
            /* 다음 버튼을 눌렀을 경우 */
            if segue.identifier == "toStarFinalRecipe" {
                let destVC = segue.destination as! FinalRecipeViewController
                destVC.title = "Starbucks Final Recipe"
                
                /* 최종 레시피에 레시피명 및 내용 넘겨주기 */
                destVC.finalRecipeName = key
                if let detailRecipe = labelStarDetailRecipe.text {
                    destVC.finalDetailRecipe = detailRecipe
                }
            }
            /* 레시피 수정 버튼을 눌럿을 경우 -> 레시피이름 넘겨주기*/
            else {
                /* 메뉴를 다시 피커에서 선택 후 검색을 누르지 않고 레시피 수정 버튼을 눌렀을 경우 -> 경고창 띄우기 */
                if labelStarDetailRecipe.text != starMenuDictionary[key] {
                    let dialog = UIAlertController(title: "오류", message: "메뉴 선택 후 다시 검색 버튼을 눌러주세요.", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                    dialog.addAction(action)
                    
                    self.present(dialog, animated: true, completion: nil)
                }
                    /* 메뉴를 다시 선택후 검색 버튼을 누른 다음에 레시피 수정 버튼을 눌렀을 경우 -> 내용넘겨주기 */
                else {
                    let destVC = segue.destination as! UpdateStarbucksMenuViewController
                    destVC.title = "Starbucks Recipe Update"
                    
                    destVC.recipeName = key
                    
                    /* update Scene에서 기존 레시피에 대한 레시피 상세내용을 default로 정해주기 위해 줄바꿈으로 분리해서 전달 */
                    var setDefault = starMenuDictionary[key]!.components(separatedBy: "\n")
                    destVC.menuName = setDefault[0]
                    for i in 1..<setDefault.count {
                        destVC.detailRecipe.append(setDefault[i])
                    }
                }
            }
        }
        /* 메뉴 선택 후 검색 하지 않고 버튼을 눌렀을 경우 경고창 띄우기 */
        else {
            let dialog = UIAlertController(title: "오류", message: "메뉴 선택 후 검색 버튼을 눌러주세요.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
}
