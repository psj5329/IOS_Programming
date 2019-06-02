//
//  ViewController.swift
//  Project
//
//  Created by kpugame on 2019. 5. 26..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchNum: UITextField!
    
    @IBAction func doneToSearchViewController(segue:UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    var url : String = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D&strSrch="
    
    
    var strSrch : String = "";
    var busRouteId : String = "";
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView"{
            if let navController = segue.destination as? UINavigationController {
                if let busListTableViewController = navController.topViewController as?
                    BusListTableViewController {
                    strSrch = searchNum.text!
                    busListTableViewController.url = url + strSrch
                }
            }
        }
    }
}

