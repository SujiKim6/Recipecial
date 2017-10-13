//
//  UpdateStarbucksMenuViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 13..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit

class UpdateStarbucksMenuViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var labelRecipeName: UILabel!
    @IBOutlet var labelMenuName: UILabel!
    @IBOutlet var pickerCoffee: UIPickerView!
    @IBOutlet var textFieldSyrup: UITextField!
    @IBOutlet var textFieldMilk: UITextField!
    @IBOutlet var textFieldWhipping: UITextField!
    @IBOutlet var textFieldDrizzle: UITextField!
    @IBOutlet var textFieldEtc: UITextField!
    
    
    let numberOfAdd:[String] = ["1","2","3","4","5","6","7","8","9"]
    let coffeeTypes:[String] = ["에스프레소", "디카페인", "1/2디카페인"]

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
    
    /* 키보드에 대한 delegate 함수 */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* 커피에 대한 picker는 두개의 component로 이루어지므로 2리턴 */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    /* 커피 picker에 몇개의 데이터를 가질지 초기화 */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // 첫번째 열인 경우
        if component == 0 {
            return coffeeTypes.count
        }
        //두번째 열인 경우
        return numberOfAdd.count
    }
    
    /* 각 picker에 각 데이터들 정의 및 글자크기 지정 */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = (view as? UILabel) ?? UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13.0)

        // 첫번째 열인 경우
        if component == 0 {
            label.text = coffeeTypes[row]
        }
        // 두번째 열인 경우
        else {
            label.text = numberOfAdd[row]
        }
        return label
    }
    
    @IBAction func btnInitialize() {
    }
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* text field를 다 입력하지 않았을 경우 */
        if textFieldMilk.text == "" || textFieldWhipping.text == "" || textFieldDrizzle.text == "" || textFieldEtc.text == "" {
            let dialog = UIAlertController(title: "오류", message: "새로운 이름을 입력해주세요.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            
            self.present(dialog, animated: true, completion: nil)
        }
        /* text field를 다 입력했을 경우 */
        else {
            // 새로운 레시피에 대한 내용 저장
            var updateRecipe = labelMenuName.text + "\n" + coffeeTypes[pickerCoffee.selectedRow(inComponent: 0)] + "\n" + numberOfAdd[pickerCoffee.selectedRow(inComponent: 1)] + "샷\n" + textFieldSyrup.text + "\n" + textFieldMilk.text + "\n" + textFieldWhipping.text + "\n" + textFieldDrizzle.text + "\n" + textFieldEtc.text
            
            // 확인 버튼을 눌러서 최종레시피화면으로 넘어갈 경우 -> 레시피명과 수정된 레시피 보내기
            if segue.identifier == "toStarUpdateFinal" {
                let destVC = segue.destination as! FinalRecipeViewController
                destVC.finalRecipeName = labelRecipeName.text + "의 최종 레시피"
                if let sendFinalRecipe = updateRecipe {
                    destVC.newRecipeDetail = sendFinalRecipe
                }
            }
            // 레시피등록 버튼을 눌러 새로운 이름을 지정하는 화면으로 넘어갈 경우 -> 브랜드와 수정된 레시피 보내기
            else if segue.identifier == "toStarAddNewRecipe" {
                let destVC = segue.destination as! AddNewRecipeViewController
                
                destVC.brandName = "Starbucks"
                if let sendFinalRecipe = updateRecipe {
                    destVC.newRecipeDetail = sendFinalRecipe
                }
            }

        }
    }
    
    
}
