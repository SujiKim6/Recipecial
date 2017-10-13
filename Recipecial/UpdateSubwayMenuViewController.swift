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
    let breadTypes:[String] = ["하티", "위트", "허니오트", "화이트", "파마산 오레가노", "플랫 브래드"]
    let cheeseTypes:[String] = ["선택안함", "아메리칸 치즈", "슈레드 치즈"]
    
    var detailRecipe:[String] = [] // 레시피를 수정할 때 기존 레시피의 내용을 그대로 가져오기 위한 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        /* 기존 레시피의 내용들을 default로 설정하기 */
        if let menu = menuName {
            labelMenuName.text = menu
        }
        var forDefault:[String] = []
        for i in 0..<detailRecipe.count {
            var seperate = detailRecipe[i].components(separatedBy: ":")
            forDefault.append(seperate[1])
        }
        
        for i in 0..<breadTypes.count {
            if forDefault[0] == breadTypes[i] {
                pickerBread.selectRow(i, inComponent: 0, animated: false)
            }
        }
        if forDefault[1] == "O" {
            segBreadCooked.selectedSegmentIndex = 0
        }
        else {
            segBreadCooked.selectedSegmentIndex = 1
        }
        for i in 0..<cheeseTypes.count {
            if forDefault[2] == cheeseTypes[i] {
                pickerCheese.selectRow(i, inComponent: 0, animated: false)
            }
        }
        textFieldAdditional.text = forDefault[3]
        textFieldVeget.text = forDefault[4]
        textFieldSauce.text = forDefault[5]
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
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 새로운 레시피에 대한 내용 저장
        var updateRecipe = "빵:" + breadTypes[pickerBread.selectedRow(inComponent: 0)]
        updateRecipe += "\n빵굽기:" + segBreadCooked.titleForSegment(at: segBreadCooked.selectedSegmentIndex)!
        if pickerCheese.selectedRow(inComponent: 0) > 0 {
            updateRecipe += "\n치즈:" + cheeseTypes[pickerCheese.selectedRow(inComponent: 0)]
        }
        else {
            updateRecipe += "\n치즈:"
        }
        if let addition = textFieldAdditional.text {
            updateRecipe += "\n추가:" + addition
        }
        if let veget = textFieldVeget.text {
            updateRecipe += "\n야채:" + veget
        }
        if let sauce = textFieldSauce.text {
            updateRecipe += "\n소스:" + sauce
        }
        
        
        // 확인 버튼을 눌러서 최종레시피화면으로 넘어갈 경우 -> 메뉴이름과 수정된 레시피 보내기
        if segue.identifier == "toSubUpdateFinal" {
            let destVC = segue.destination as! FinalRecipeViewController
            destVC.title = "Subway Final Recipe"
            
            if let recipeName = labelMenuName.text {
                destVC.finalRecipeName = recipeName
            }
            destVC.finalDetailRecipe = updateRecipe
        }
            // 레시피 등록 버튼을 눌러서 레시피 추가화면으로 넘어갈 경우 -> 브랜드명과 수정된 레시피 보내기
        else {
            let destVC = segue.destination as! AddNewRecipeViewController
            destVC.brandName = "Subway"
            destVC.newRecipeDetail = updateRecipe
        }
    }
    
    
}
