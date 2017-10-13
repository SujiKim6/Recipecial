//
//  UpdateSubwayMenuViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 13..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit

class UpdateSubwayMenuViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var labelMenuName: UILabel!
    @IBOutlet var pickerBread: UIPickerView!
    @IBOutlet var pickerCheese: UIPickerView!
    @IBOutlet var textFieldAdditional: UITextField!
    @IBOutlet var textFieldVeget: UITextField!
    @IBOutlet var textFieldSauce: UITextField!
    @IBOutlet var segBreadCooked: UISegmentedControl!
    
    var menuName:String?
    let breadTypes:[String] = ["하티", "위트", "허니오트", "화이트", "파마산 오레가노", "플랫 브레드"]
    let cheeseTypes:[String] = ["아메리칸 치즈", "슈레드 치즈"]
    
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
    
    /* 빵에 대한 picker 와 치즈에 대한 picker는 하나의 component로 이루어지므로 1리턴 */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /* 각 picker에 몇개의 데이터를 가질지 초기화 */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // 빵에 대한 picker인 경우
        if pickerView == pickerBread {
            return breadTypes.count
        }
        //치즈에 대한 picker인 경우
        return cheeseTypes.count
    }
    
    /* 각 picker에 각 데이터들 정의 및 글자크기 지정 */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = (view as? UILabel) ?? UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13.0)
        
        // 빵에 대한 picker인 경우
        if pickerView == pickerBread {
            label.text = breadTypes[row]
        }
        // 치즈에 대한 picker인 경우
        else {
            label.text = cheeseTypes[row]
        }
    
        return label
    }
    
    /* 초기화 버튼 눌렀을 경우 */
    @IBAction func btnInitialize() {
    }
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /* text field를 다 입력하지 않았을 경우 */
        if textFieldAdditional.text == "" && textFieldVeget.text == "" && textFieldSauce.text == "" {
            let dialog = UIAlertController(title: "오류", message: "새로운 이름을 입력해주세요.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            
            self.present(dialog, animated: true, completion: nil)
        }
        /* text field를 다 입력했을 경우 */
        else {
            // 새로운 레시피에 대한 내용 저장
            var updateRecipe = labelMenuName.text + "\n" + breadTypes[pickerBread.selectedRow(inComponent: 0)] + "\n" + "빵 굽기" + segBreadCooked.titleForSegment(at: segBreadCooked.selectedSegmentIndex) + "\n" + cheeseTypes[pickerCheese.selectedRow(inComponent: 0)] + "\n" + textFieldAdditional.text + "\n" + textFieldVeget.text + "\n" + textFieldSauce.text
            
            // 확인 버튼을 눌러서 최종레시피화면으로 넘어갈 경우 -> 메뉴이름과 수정된 레시피 보내기
            if segue.identifier == "toSubUpdateFinal" {
                let destVC = segue.destination as! FinalRecipeViewController
                destVC.finalRecipeName = labelMenuName.text + "의 최종 레시피"
                if let sendFinalRecipe = updateRecipe {
                    destVC.newRecipeDetail = sendFinalRecipe
                }
            }
            // 레시피등록 버튼을 눌러 새로운 이름을 지정하는 화면으로 넘어갈 경우 -> 브랜드와 수정된 레시피 보내기
            else if segue.identifier == "toSubAddNewRecipe" {
                let destVC = segue.destination as! AddNewRecipeViewController
                
                destVC.brandName = "Subway"
                if let sendFinalRecipe = updateRecipe {
                    destVC.newRecipeDetail = sendFinalRecipe
                }
            }
            
        }
    }
    
    
}
