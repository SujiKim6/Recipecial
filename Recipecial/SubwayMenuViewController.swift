//
//  SubwayMenuViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit
import CoreData

class SubwayMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerSubMenu: UIPickerView!
    @IBOutlet var labelSubDetailRecipe: UILabel!
    
    var subMenuDictionary:[String:String] = [:] // picker에 들어갈 메뉴와 그 메뉴에 해당하는 레시피 저장
    var sortedKeys : Array<String> = [] // picker에 메뉴가 정렬된 상태로 추가하기 위해 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* 코어데이터에서 데이터를 조회해서 subMenuDictionary에 추가하기 */
        let context = self.getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
//            print(results.count)
            for menuList in results as! [NSManagedObject] {
                if let brandName = menuList.value(forKey: "brand") as? String,
                    let recipeName = menuList.value(forKey: "menuName") as? String,
                    let detailRecipe = menuList.value(forKey: "detailMenu") as? String
                {
                    print(recipeName)
                    print(detailRecipe)
                    if brandName == "Subway" {
                        subMenuDictionary[recipeName] = detailRecipe
                    }
                }
            }
//            print(subMenuDictionary)
        } catch {
            print("Find error")
        }
        
        /* key 값만 추출하여 정렬 후 배열에 배정 */
        let unsortedKeys = Array(subMenuDictionary.keys)
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
        let index = pickerSubMenu.selectedRow(inComponent: 0)
        let key:String = sortedKeys[index]
        
        labelSubDetailRecipe.text = subMenuDictionary[key]
    }
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = pickerSubMenu.selectedRow(inComponent: 0)
        let key:String = sortedKeys[index]
        
        if labelSubDetailRecipe.text != "Detail Recipe" {
            /* 다음 버튼을 눌렀을 경우 */
            if segue.identifier == "toSubFinalRecipe" {
                let destVC = segue.destination as! FinalRecipeViewController
                destVC.title = "Subway Final Recipe"
                
                /* 최종 레시피에 레시피명 및 내용 넘겨주기 */
                destVC.finalRecipeName = key + "의 최종 레시피"
                if let detailRecipe = labelSubDetailRecipe.text {
                    destVC.finalDetailRecipe = detailRecipe
                }
            }
            /* 레시피 수정 버튼을 눌렀을 경우 */
            else {
                let destVC = segue.destination as! UpdateSubwayMenuViewController
                destVC.title = "Subway Recipe Update"
            }
        }
        /* 메뉴 선택 후 검색 하지 않고 넘겼을 경우 경고창 띄우기 */
        else {
            let dialog = UIAlertController(title: "오류", message: "메뉴 선택 후 검색 버튼을 눌러주세요.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            
            self.present(dialog, animated: true, completion: nil)
        }
    }

}
