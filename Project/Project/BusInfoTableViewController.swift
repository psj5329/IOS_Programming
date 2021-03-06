//
//  BusInfoTableViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 17..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class BusInfoTableViewController: UITableViewController, XMLParserDelegate {
    
    @IBOutlet var detailTableView: UITableView!
    
    var url : String = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    
    var parser = XMLParser()
    
    let postname : [String] = ["노선 ID", "노선명", "노선 길이(km)", "노선 유형", "기점", "종점", "배차간격(분)", "막차 운행 여부", "금일 첫차 시간", "금일 막차 시간", "금일 저상 첫차 시간", "금일 저상 막차 시간", "운수사명"]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        
        beginParsing()
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        detailTableView.reloadData()}

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
    
    var type = ""
    var YN = ""
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "busRouteId"){
            busRouteId.append(string)
        } else if element.isEqual(to: "busRouteNm"){
            busRouteNm.append(string)
        } else if element.isEqual(to: "length"){
            length.append(string)
        } else if element.isEqual(to: "routeType"){
            switch (string) {
            case "1": type = "공항"; break;
            case "2": type = "마을"; break;
            case "3": type = "간선"; break;
            case "4": type = "지선"; break;
            case "5": type = "순환"; break;
            case "6": type = "광역"; break;
            case "7": type = "인천"; break;
            case "8": type = "경기"; break;
            case "9": type = "폐지"; break;
            case "0": type = "공용"; break;
            default: break;
            }
            routeType.append(type)
        } else if element.isEqual(to: "stStationNm"){
            stStationNm.append(string)
        } else if element.isEqual(to: "edStationNm"){
            edStationNm.append(string)
        } else if element.isEqual(to: "term"){
            term.append(string)
        } else if element.isEqual(to: "lastBusYn"){
            if(string == ""){
                YN = "No"
            }
            lastBusYn.append(YN)
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return posts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusInfoCell", for: indexPath)
        
        cell.textLabel?.text = posts[indexPath.row]
        cell.detailTextLabel?.text = postname[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
