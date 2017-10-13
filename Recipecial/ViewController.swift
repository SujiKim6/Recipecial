//
//  ViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let context = self.getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        request.returnsObjectsAsFaults = false
        
        var numOfResults:Int = 0
        
        /* 현재 Core Data에 저장되어 있는 내용이 있는가? -> 없다면 default값 추가 (어플 처음 다운 받았을 때 기본적으로 저장해두기 위함. */
        do{
            let results = try context.fetch(request)
            numOfResults = results.count
        } catch {
            print("Find error")
        }
        print(numOfResults)
        /* Core Data에 저장되어 있는 내용이 없을 경우, 각 브랜드의 추천 레시피 등록 */
        if numOfResults <= 0 {
            /* 서브웨이 레시피명 및 상세레시피 내용 저장하는 배열 선언 */
            let subRecipeName = ["스테이크&치즈", "B.L.T 레시피 1", "B.L.T 레시피 2", "스파이시 이탈리안", "에그마요", "치킨데리야끼", "이탈리아 B.M.T"]
            let subDetailRecipe = ["빵:플랫 브래드\n빵굽기:O\n치즈:\n추가:\n야채:취향대로\n소스:마요네즈, 바베큐",
                                   "빵:파마산 오레가노\n빵굽기:O\n치즈:\n추가:오믈렛\n야채:취향대로\n소스:스위트 어니언, 사우스 웨스트, 후추",
                                   "빵:플랫 브래드\n빵굽기:O\n치즈:\n추가:\n야채:취향대로\n소스:마요네즈, 스위트 칠리",
                                   "빵:화이트\n빵굽기:O\n치즈:\n추가:\n야채:올리브 많이\n소스:핫칠리, 스위트칠리",
                                   "빵:허니오트\n빵굽기:O\n치즈:\n추가:\n야채:야채많이\n소스:마요네즈, 렌치 드레싱, 후추듬뿍",
                                   "빵:허니오트\n빵굽기:O\n치즈:\n추가:\n야채:취향대로\n소스:바베큐, 스위트 어니언, 렌치 드레싱",
                                   "빵:플랫 브래드\n빵굽기:O\n치즈:\n추가:\n야채:취향대로\n소스:스위트 칠리, 스위트 어니언, 랜치 드레싱"]
            
            /* 서브웨이 레시피명 및 상세레시피 내용 저장하는 배열 선언 */
            let starRecipeName = ["슈렉프라푸치노", "캡틴크런치베리프라푸치노", "고디바프라푸치노", "돼지바프라푸치노", "트윅스프라푸치노", "스니커즈프라푸치노", "바닐라 크림파이 프라푸치노"]
            let starDetailRecipe = ["그린티프라푸치노\n커피:에스프레소 1샷\n시럽:\n우유:우유\n휘핑:초코휘핑\n드리즐:초코드리즐\n기타:자바칩, 통자바칩",
                                    "두유딸기크림프라푸치노\n커피:\n시럽:헤이즐넛시럽 2펌프\n우유:우유\n휘핑:\n드리즐:\n기타:",
                                    "자바칩프라푸치노\n커피:\n시럽:헤이즐넛시럽 3펌프, 모카시럽 5펌프\n우유:우유\n휘핑:\n드리즐:\n기타:프라푸치노로스트 4번",
                                    "딸기크림프라푸치노\n커피:\n시럽:딸기시럽 6펌프\n우유:우유\n휘핑:\n드리즐:초코드리즐(바닥, 휘핑)\n기타:자바칩",
                                    "카라멜프라푸치노\n커피:\n시럽:헤이즐넛시럽 1펌프\n우유:우유\n휘핑:\n드리즐:초코드리즐(바닥, 휘핑), 카라멜드리즐(바닥, 휘핑)\n기타:자바칩(반은 갈고 반은 토핑)",
                                    "자바칩프라푸치노\n커피:\n시럽:헤이즐넛시럽 2펌프\n우유:우유\n휘핑:\n드리즐:카라멜 드리즐\n기타:",
                                    "바닐라프라푸치노\n커피:\n시럽:바닐라시럽 1펌프, 헤이즐넛시럽 1펌프\n우유:우유\n휘핑:\n드리즐:\n기타:바나나 추가"]
            
            /* 코어 데이터에 기존 추천 레시피 코어데이터에 저장 */
            //          let context = self.getContext()
            for i in 0..<subRecipeName.count {
                do {
                    let newRecipes = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context)
                    newRecipes.setValue("Subway", forKey: "brand")
                    newRecipes.setValue(subRecipeName[i], forKey: "menuName")
                    newRecipes.setValue(subDetailRecipe[i], forKey: "detailMenu")
                    
                    try context.save()
                    print("Success Saving1")
                }
                catch {
                    //Error 발생시
                    print("Fail Saving")
                }
            }
            for i in 0..<starRecipeName.count {
                do {
                    let newRecipes = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context)
                    newRecipes.setValue("Starbucks", forKey: "brand")
                    newRecipes.setValue(starRecipeName[i], forKey: "menuName")
                    newRecipes.setValue(starDetailRecipe[i], forKey: "detailMenu")
                    
                    try context.save()
                    print("Success Saving1")
                }
                catch {
                    //Error 발생시
                    print("Fail Saving")
                }
            }
        }
        
//        /* Core Data내에 저장된 모든 내용 삭제하는 법 */
//        let context = self.getContext()
//    
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//            print("Success Delete")
//        } catch {
//            print ("There was an error")
//        }
//
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Core Data 사용을 위한 함수 */
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
}

