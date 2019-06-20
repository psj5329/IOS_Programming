//
//  StationInfoViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 20..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class StationInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {

    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationNum: UILabel!
    @IBOutlet weak var stationEnd: UILabel!
    
    var url = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    var urlBus = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    
    var parser = XMLParser()
    
    let postsname : [String] = ["정류장 ID", "정류장 이름", "다음 정류장", "X좌표", "Y좌표", "첫차 시간", "막차 시간"]
    var posts : [String] = ["", "", "", "", "", "", ""]
    
    //var posts = NSMutableArray()
    //var elements = NSMutableDictionary()
    
    var element = NSString()
    
    var stationNo = NSMutableString()
    var stationNm = NSMutableString()
    var stationNext = NSMutableString()
    var posX = NSMutableString()
    var posY = NSMutableString()
    var beginTm = NSMutableString()
    var lastTm = NSMutableString()
    
    var busRouteId = ""
    var stNum = ""
    var stName = ""
    var stNext = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        
        beginParsing()
        // Do any additional setup after loading the view.
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        detailTableView.reloadData()
        
        stationNum.text = stNum as String
        stationName.text = stName as String
        stationEnd.text = stNext as String + " 방면"
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "itemList")
        {
            posts = ["", "", "", "", "", "", ""]
            //elements = NSMutableDictionary()
            //elements = [:]
            
            stationNo = NSMutableString()
            stationNo = ""
            stationNm = NSMutableString()
            stationNm = ""
            stationNext = NSMutableString()
            stationNext = ""
            posX = NSMutableString()
            posX = ""
            posY = NSMutableString()
            posY = ""
            beginTm = NSMutableString()
            beginTm = ""
            lastTm = NSMutableString()
            lastTm = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "stationNo"){
            stationNo.append(string)
        } else if element.isEqual(to: "stationNm"){
            stationNm.append(string)
        } else if element.isEqual(to: "direction"){
            stationNext.append(string)
        } else if element.isEqual(to: "posX"){
            posX.append(string)
        } else if element.isEqual(to: "posY"){
            posY.append(string)
        } else if element.isEqual(to: "beginTm"){
            beginTm.append(string)
        } else if element.isEqual(to: "lastTm"){
            lastTm.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "itemList")
        {
            /*if !stationNo.isEqual(nil){
                elements.setObject(stationNo, forKey: "stationNo" as NSCopying)
            }
            if !stationNm.isEqual(nil){
                elements.setObject(stationNm, forKey: "stationNm" as NSCopying)
            }
            if !stationEnd.isEqual(nil){
                elements.setObject(stationEnd, forKey: "direction" as NSCopying)
            }
            if !posX.isEqual(nil){
                elements.setObject(posX, forKey: "posX" as NSCopying)
            }
            if !posY.isEqual(nil){
                elements.setObject(posY, forKey: "posY" as NSCopying)
            }
            if !beginTm.isEqual(nil){
                elements.setObject(beginTm, forKey: "beginTm" as NSCopying)
            }
            if !lastTm.isEqual(nil){
                elements.setObject(lastTm, forKey: "lastTm" as NSCopying)
            }
            
            posts.add(elements)*/
            
            if !stationNo.isEqual(nil){
                posts[0] = stationNo as String
            }
            if !stationNo.isEqual(nil){
                posts[1] = stationNm as String
            }
            if !stationNo.isEqual(nil){
                posts[2] = stationNext as String
            }
            if !stationNo.isEqual(nil){
                posts[3] = posX as String
            }
            if !stationNo.isEqual(nil){
                posts[4] = posY as String
            }
            if !stationNo.isEqual(nil){
                posts[5] = beginTm as String
            }
            if !stationNo.isEqual(nil){
                posts[6] = lastTm as String
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the numb나도er of sections
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationInfoCell", for: indexPath)
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: nil)
        
        //cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "stationNm") as! NSString as String
        //cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "stationNo") as! NSString as String
        
        cell.textLabel?.text = posts[indexPath.row]
        cell.detailTextLabel?.text = postsname[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToStationMapView"{
            if let mapViewController = segue.destination as? StationMapViewController{
                mapViewController.url = mapViewController.url + "&busRouteId=" + busRouteId
                mapViewController.posts = NSMutableArray(array: posts)
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
