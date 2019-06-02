//
//  BusListTableViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 2..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class BusListTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbBusData: UITableView!
    
    var url : String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var busRouteNm = NSMutableString()
    var routeType = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
    }

    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        tbBusData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "itemList")
        {
            elements = NSMutableDictionary()
            elements = [:]
            busRouteNm = NSMutableString()
            busRouteNm = ""
            routeType = NSMutableString()
            routeType = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "busRouteNm") {
            busRouteNm.append(string)
        } else if element.isEqual(to: "routeType"){
            routeType.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "itemList") {
            if !busRouteNm.isEqual(nil){
                elements.setObject(busRouteNm, forKey: "busRouteNm" as NSCopying)
            }
            if !routeType.isEqual(nil){
                elements.setObject(routeType, forKey: "routeType" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "busRouteNm") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "routeType") as! NSString as String
        
        if(cell.detailTextLabel?.text == "1")
        {
            cell.detailTextLabel?.text = "공항"
        }
        else if(cell.detailTextLabel?.text == "2")
        {
            cell.detailTextLabel?.text = "마을"
        }
        else if(cell.detailTextLabel?.text == "3")
        {
            cell.detailTextLabel?.text = "간선"
        }
        else if(cell.detailTextLabel?.text == "4")
        {
            cell.detailTextLabel?.text = "지선"
        }
        else if(cell.detailTextLabel?.text == "5")
        {
            cell.detailTextLabel?.text = "순환"
        }
        else if(cell.detailTextLabel?.text == "6")
        {
            cell.detailTextLabel?.text = "광역"
        }
        else if(cell.detailTextLabel?.text == "7")
        {
            cell.detailTextLabel?.text = "인천"
        }
        else if(cell.detailTextLabel?.text == "8")
        {
            cell.detailTextLabel?.text = "경기"
        }
        else if(cell.detailTextLabel?.text == "9")
        {
            cell.detailTextLabel?.text = "폐지"
        }
        else if(cell.detailTextLabel?.text == "0")
        {
            cell.detailTextLabel?.text = "공용"
        }
        
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
