//
//  BusInfoViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 3..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class BusInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {

    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var busNum: UILabel!
    @IBOutlet weak var busStart: UILabel!
    @IBOutlet weak var busEnd: UILabel!
    
    var url = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    var urlStation = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    
    var parser = XMLParser()
    
    //let postname : [String] = ["정류소 고유 번호", "정류소명", "첫차 시간", "막차 시간"]
    //var posts : [String] = ["", "", "", ""]
    
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    
    var element = NSString()
    
    var stationNo = NSMutableString()
    var stationNm = NSMutableString()
    var beginTm = NSMutableString()
    var lastTm = NSMutableString()
    var direction = NSMutableString()
    
    var busRouteId = ""
    var busRouteNm = ""
    var stStationNm = ""
    var edStationNm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        
        beginParsing()
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:urlStation))!)!
        parser.delegate = self
        parser.parse()
        detailTableView.reloadData()
        
        busNum.text = busRouteNm as String
        busStart.text = stStationNm as String
        busEnd.text = edStationNm as String
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "itemList")
        {
            //posts = ["", "", "", ""]
            elements = NSMutableDictionary()
            elements = [:]
            
            stationNo = NSMutableString()
            stationNo = ""
            stationNm = NSMutableString()
            stationNm = ""
            beginTm = NSMutableString()
            beginTm = ""
            lastTm = NSMutableString()
            lastTm = ""
            direction = NSMutableString()
            direction = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "stationNo"){
            stationNo.append(string)
        } else if element.isEqual(to: "stationNm"){
            stationNm.append(string)
        } else if element.isEqual(to: "beginTm"){
            beginTm.append(string)
        } else if element.isEqual(to: "lastTm"){
            lastTm.append(string)
        } else if element.isEqual(to: "direction"){
            direction.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "itemList")
        {
            if !stationNo.isEqual(nil){
                elements.setObject(stationNo, forKey: "stationNo" as NSCopying)
            }
            if !stationNm.isEqual(nil){
                elements.setObject(stationNm, forKey: "stationNm" as NSCopying)
            }
            if !beginTm.isEqual(nil){
                elements.setObject(beginTm, forKey: "beginTm" as NSCopying)
            }
            if !lastTm.isEqual(nil){
                elements.setObject(lastTm, forKey: "lastTm" as NSCopying)
            }
            if !direction.isEqual(nil){
                elements.setObject(direction, forKey: "direction" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    /*func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusRouteCell", for: indexPath)
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: nil)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "stationNm") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "stationNo") as! NSString as String
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMapView"{
            if let mapViewController = segue.destination as? MapViewController{
                mapViewController.url = mapViewController.url + "&busRouteId=" + busRouteId
                //mapViewController.posts = posts
            }
        }
        
        if segue.identifier == "segueToInfoView"{
            if let infoViewController = segue.destination as? BusInfoTableViewController{
                infoViewController.url = infoViewController.url + "&strSrch=" + busRouteNm
            }
        }
        
        if segue.identifier == "segueToStationView" {
            if let cell = sender as? UITableViewCell{
                let indexPath = detailTableView.indexPath(for: cell)
                
                if let infoViewController = segue.destination as? StationInfoViewController{
                    let stNo = (posts.object(at: ((indexPath?.row)!)) as AnyObject).value(forKey: "stationNo") as! NSString as String
                    infoViewController.stNum = stNo
                    
                    let stNext = (posts.object(at: ((indexPath?.row)!)) as AnyObject).value(forKey: "direction") as! NSString as String
                    infoViewController.stNext = stNext
                    
                    let stNm = (posts.object(at: ((indexPath?.row)!)) as AnyObject).value(forKey: "stationNm") as! NSString as String
                    infoViewController.stName = stNm
                    
                    infoViewController.busRouteId = busRouteId
                
                    infoViewController.url = infoViewController.url + "&busRouteId=" + busRouteId
                }
            }
        }
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
