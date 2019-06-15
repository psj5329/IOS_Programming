//
//  BusInfoViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 3..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class BusInfoViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var busNum: UILabel!
    @IBOutlet weak var busStart: UILabel!
    @IBOutlet weak var busEnd: UILabel!
    var url : String?
    
    var parser = XMLParser()
    
    let postname : [String] = ["노선 ID", "노선명", "노선 길이(km)", "노선 유형", "기점", "종점", "배차간격", "막차 운행 여부", "금일 첫차 시간", "금일 막차 시간", "금일 저상 첫차 시간", "금일 저상 막차 시간", "운수사명"]
    var posts : [String] = ["", "", "", "", "", "", "", "", "", "", "", "", ""]
    var element = NSString()
    
    var busRouteId = NSMutableString()
    var busRouteNm = NSMutableString()
    var length = NSMutableString()
    var routeType = NSMutableString()
    var stStationNm = NSMutableString()
    var edStationNm = NSMutableString()
    var term = NSMutableString()
    var lastBusYn = NSMutableString()
    var firstBusTm = NSMutableString()
    var lastBusTm = NSMutableString()
    var firstLowTm = NSMutableString()
    var lastLowTm = NSMutableString()
    var corpNm = NSMutableString()
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "itemList")
        {
            posts = ["", "", "", "", "", "", "", "", "", "", "", "", ""]
            
            busRouteId = NSMutableString()
            busRouteId = ""
            busRouteNm = NSMutableString()
            busRouteNm = ""
            length = NSMutableString()
            length = ""
            routeType = NSMutableString()
            routeType = ""
            stStationNm = NSMutableString()
            stStationNm = ""
            edStationNm = NSMutableString()
            edStationNm = ""
            term = NSMutableString()
            term = ""
            lastBusYn = NSMutableString()
            lastBusYn = ""
            firstBusTm = NSMutableString()
            firstBusTm = ""
            lastBusTm = NSMutableString()
            lastBusTm = ""
            firstLowTm = NSMutableString()
            firstLowTm = ""
            lastLowTm = NSMutableString()
            lastLowTm = ""
            corpNm = NSMutableString()
            corpNm = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "busRouteId"){
            busRouteId.append(string)
        } else if element.isEqual(to: "busRouteNm"){
            busRouteNm.append(string)
        } else if element.isEqual(to: "length"){
            length.append(string)
        } else if element.isEqual(to: "routeType"){
            routeType.append(string)
        } else if element.isEqual(to: "stStationNm"){
            stStationNm.append(string)
        } else if element.isEqual(to: "edStationNm"){
            edStationNm.append(string)
        } else if element.isEqual(to: "term"){
            term.append(string)
        } else if element.isEqual(to: "lastBusYn"){
            lastBusYn.append(string)
        } else if element.isEqual(to: "firstBusTm"){
            firstBusTm.append(string)
        } else if element.isEqual(to: "lastBusTm"){
            lastBusTm.append(string)
        } else if element.isEqual(to: "firstLowTm"){
            firstLowTm.append(string)
        } else if element.isEqual(to: "lastLowTm"){
            lastLowTm.append(string)
        } else if element.isEqual(to: "corpNm"){
            corpNm.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "itemList")
        {
            if !busRouteId.isEqual(nil){
                posts[0] = busRouteId as String
            }
            if !busRouteId.isEqual(nil){
                posts[1] = busRouteNm as String
            }
            if !busRouteId.isEqual(nil){
                posts[2] = length as String
            }
            if !busRouteId.isEqual(nil){
                posts[3] = routeType as String
            }
            if !busRouteId.isEqual(nil){
                posts[4] = stStationNm as String
            }
            if !busRouteId.isEqual(nil){
                posts[5] = edStationNm as String
            }
            if !busRouteId.isEqual(nil){
                posts[6] = term as String
            }
            if !busRouteId.isEqual(nil){
                posts[7] = lastBusYn as String
            }
            if !busRouteId.isEqual(nil){
                posts[8] = firstBusTm as String
            }
            if !busRouteId.isEqual(nil){
                posts[9] = lastBusTm as String
            }
            if !busRouteId.isEqual(nil){
                posts[10] = firstLowTm as String
            }
            if !busRouteId.isEqual(nil){
                posts[11] = lastLowTm as String
            }
            if !busRouteId.isEqual(nil){
                posts[12] = corpNm as String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: nil)
        
        cell.textLabel?.text = postname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        
        busNum.text = postname[1]
        busStart.text = postname[4]
        busEnd.text = postname[5]
        // Configure the cell...
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
