//
//  RateOrderVC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation
import UIKit

extension RateOrderVC : UITableViewDelegate,UITableViewDataSource {
    
    func setupTableView()
    {
        rateTable.delegate = self
        rateTable.dataSource = self
        rateTable.register(UINib.init(nibName: "RateOrderCell", bundle:nil), forCellReuseIdentifier: "cell")
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rateOrderVM?.qusArr?.count ?? 0
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RateOrderCell
       
    cell.configCell(Ques:(rateOrderVM?.qusArr?[indexPath.row])!)
        cell.btnBad.tag = indexPath.row
        cell.btnGood.tag = indexPath.row

        cell.btnBad.addTarget(self, action: #selector(badAction(_:)), for: .touchUpInside)
        cell.btnGood.addTarget(self, action: #selector(goodAction(_:)), for: .touchUpInside)
        
        for question in answersArray{
            if question.id! == rateOrderVM?.qusArr?[indexPath.row].id
        {
                if question.title == "good" {
                cell.selectGood()
            }else
            {
                cell.selectBad()
            }
                break
                
        }
        
    }
        
        return cell
        
    }
    
    @objc func badAction(_ sender:UIButton){
        var selectedIndex = -1
        if answersArray.count == 0 {
            answersArray.append(questions(id:rateOrderVM.qusArr?[sender.tag].id , title: "bad"))
            
        }
        else{
            
            for index in 0..<(answersArray.count)
            {
                if rateOrderVM.qusArr?[sender.tag].id == answersArray[index].id
                {
                    selectedIndex = index
                }
            }
            if selectedIndex == -1 {
                answersArray.append(questions(id:rateOrderVM.qusArr?[sender.tag].id  , title: "bad"))
            }
            else
            {
                answersArray[selectedIndex] = (questions(id:rateOrderVM.qusArr?[sender.tag].id  , title: "bad"))
                
            }
        }
        print(answersArray)
        let indexPath = IndexPath(item: sender.tag, section: 0)
        rateTable.reloadRows(at: [indexPath], with: .fade)

    }
    
    @objc func goodAction(_ sender:UIButton){
        var selectedIndex = -1
        if answersArray.count == 0 {
            answersArray.append(questions(id:rateOrderVM.qusArr?[sender.tag].id  , title: "good"))
        }
        else{
            
            for index in 0..<(answersArray.count)
            {
                if rateOrderVM.qusArr?[sender.tag].id == answersArray[index].id
                {
                    selectedIndex = index
                }
            }
            if selectedIndex == -1 {
            answersArray.append(questions(id:rateOrderVM.qusArr?[sender.tag].id  , title: "good"))
            }
            else
            {
                answersArray[selectedIndex] = (questions(id:rateOrderVM.qusArr?[sender.tag].id  , title: "good"))
            }
            }
        print(answersArray)
        
        let indexPath = IndexPath(item: sender.tag, section: 0)
        rateTable.reloadRows(at: [indexPath], with: .fade)
        }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    

}
