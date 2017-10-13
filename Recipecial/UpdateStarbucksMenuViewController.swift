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
    
    var recipeName:String?
    let numberOfAdd:[String] = ["1","2","3","4","5","6","7","8","9"]
    let coffeeTypes:[String] = ["선택안함","에스프레소", "디카페인", "1/2디카페인"]
    var menuName:String?
    var detailRecipe:[String] = [] // 레시피를 수정할 때 기존 레시피의 내용을 그대로 가져오기 위한 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let recipe = recipeName {
            labelRecipeName.text = recipe
        }
        if let menu = menuName {
            labelMenuName.text = menu
        }
        var forDefault:[String] = []
        for i in 0..<detailRecipe.count {
            var seperate = detailRecipe[i].components(separatedBy: ":")
            forDefault.append(seperate[1])
        }
        
        // 커피에 대한 picker는 component가 2개이므로 띄어쓰기로 분리한다.
        var coffee = forDefault[0].components(separatedBy: " ")
        for i in 0..<coffeeTypes.count { // 커피 샷의 종류
            if coffee[0] == coffeeTypes[i] {
                pickerCoffee.selectRow(i, inComponent: 0, animated: false)
            }
        }
        if coffee.count == 2 {
            for i in 0..<numberOfAdd.count { // 커피 샷의 갯수
                if coffee[1] == (numberOfAdd[i]+"샷") {
                    pickerCoffee.selectRow(i, inComponent: 1, animated: false)
                }
            }
        }
        textFieldSyrup.text = forDefault[1]
        textFieldMilk.text = forDefault[2]
        textFieldWhipping.text = forDefault[3]
        textFieldDrizzle.text = forDefault[4]
        textFieldEtc.text = forDefault[5]
        
        /* 키보드 delegata & 키보드 화면에 따라 이동시키기 위한 함수 */
        textFieldSyrup.delegate = self
        textFieldMilk.delegate = self
        textFieldWhipping.delegate = self
        textFieldDrizzle.delegate = self
        textFieldEtc.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
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
    /* 키보드가 올라왔을 때 -> 화면 위로 올리기 */
    func keyboardWillShow(_ sender: Notification) {
        
        self.view.frame.origin.y = -150 // Move view 150 points upward
        
    }
    /* 키보드가 내려갔을 때 -> 화면 다시 제위치 */
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
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
    
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 새로운 레시피에 대한 내용 저장
        var updateRecipe = labelMenuName.text!
        if pickerCoffee.selectedRow(inComponent: 0) > 0 {
            updateRecipe += "\n커피:" + coffeeTypes[pickerCoffee.selectedRow(inComponent: 0)]
            updateRecipe += " " + numberOfAdd[pickerCoffee.selectedRow(inComponent: 1)] + "샷"
        }
        else {
            updateRecipe += "\n커피:"
        }
        if let syrup = textFieldSyrup.text {
            updateRecipe += "\n시럽:" + syrup
        }
        if let milk = textFieldMilk.text {
            updateRecipe += "\n우유:" + milk
        }
        if let whipping = textFieldWhipping.text {
            updateRecipe += "\n소스:" + whipping
        }
        if let drizzle = textFieldDrizzle.text {
            updateRecipe += "\n드리즐:" + drizzle
        }
        if let etc = textFieldEtc.text {
            updateRecipe += "\n기타:" + etc
        }
        
        
        // 확인 버튼을 눌러서 최종레시피화면으로 넘어갈 경우 -> 메뉴이름과 수정된 레시피 보내기
        if segue.identifier == "toStarUpdateFinal" {
            let destVC = segue.destination as! FinalRecipeViewController
            destVC.title = "Starbucks Final Recipe"
            
            if let recipeName = labelMenuName.text {
                destVC.finalRecipeName = recipeName
            }
            destVC.finalDetailRecipe = updateRecipe
        }
            // 레시피 등록 버튼을 눌러서 레시피 추가화면으로 넘어갈 경우 -> 브랜드명과 수정된 레시피 보내기
        else {
            let destVC = segue.destination as! AddNewRecipeViewController
            destVC.brandName = "Starbucks"
            destVC.newRecipeDetail = updateRecipe
        }
    }
    
    
}
