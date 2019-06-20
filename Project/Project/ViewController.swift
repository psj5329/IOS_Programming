//
//  ViewController.swift
//  Project
//
//  Created by kpugame on 2019. 5. 26..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, XMLParserDelegate {
    
    @IBOutlet weak var SearchBusList: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    var url : String = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    var strurl : String = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var busRouteNm = NSMutableString()
    var busRouteId = NSMutableString()
    var routeType = NSMutableString()
    var stStationNm = NSMutableString()
    var edStationNm = NSMutableString()
    
    var audioController: AudioController
    
    var busNum_utf8: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SearchBusList.dataSource = self
        self.SearchBusList.delegate = self
        self.searchbar.delegate = self
        self.searchbar.placeholder = "Input Bus Number"
        
        beginParsing()
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:strurl))!)!
        parser.delegate = self
        parser.parse()
        SearchBusList.reloadData()
        
        let startX: CGFloat = ScreenWidth - 100
        let startY: CGFloat = 100
        let endY: CGFloat = ScreenHeight + 300
        
        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
        self.view.addSubview(stars)
        self.view.sendSubviewToBack(_: stars)
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {stars.center = CGPoint(x: startX, y: endY)}, completion: {(value:Bool) in stars.removeFromSuperview()})
    }
    
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "itemList")
        {
            elements = NSMutableDictionary()
            elements = [:]
            busRouteNm = NSMutableString()
            busRouteNm = ""
            busRouteId = NSMutableString()
            busRouteId = ""
            routeType = NSMutableString()
            routeType = ""
            stStationNm = ""
            stStationNm = NSMutableString()
            edStationNm = ""
            edStationNm = NSMutableString()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "busRouteNm") {
            busRouteNm.append(string)
        } else if element.isEqual(to: "busRouteId"){
            busRouteId.append(string)
        } else if element.isEqual(to: "routeType"){
            routeType.append(string)
        } else if element.isEqual(to: "stStationNm"){
            stStationNm.append(string)
        } else if element.isEqual(to: "edStationNm"){
            edStationNm.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "itemList") {
            if !busRouteNm.isEqual(nil){
                elements.setObject(busRouteNm, forKey: "busRouteNm" as NSCopying)
            }
            if !busRouteId.isEqual(nil){
                elements.setObject(busRouteId, forKey: "busRouteId" as NSCopying)
            }
            if !routeType.isEqual(nil){
                elements.setObject(routeType, forKey: "routeType" as NSCopying)
            }
            if !stStationNm.isEqual(nil){
                elements.setObject(stStationNm, forKey: "stStationNm" as NSCopying)
            }
            if !edStationNm.isEqual(nil){
                elements.setObject(edStationNm, forKey: "edStationNm" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
       
        cell.textLabel?.text = "버스 번호 : " + ((posts.object(at: indexPath.row) as AnyObject).value(forKey: "busRouteNm") as! NSString as String)
       cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "routeType") as! NSString as String
       
       if(cell.detailTextLabel?.text == "1")
       {
        cell.detailTextLabel?.text = "버스 유형 : 공항"
       }
       else if(cell.detailTextLabel?.text == "2")
       {
           cell.detailTextLabel?.text = "버스 유형 : 마을"
       }
       else if(cell.detailTextLabel?.text == "3")
       {
           cell.detailTextLabel?.text = "버스 유형 : 간선"
       }
       else if(cell.detailTextLabel?.text == "4")
       {
           cell.detailTextLabel?.text = "버스 유형 : 지선"
       }
       else if(cell.detailTextLabel?.text == "5")
       {
           cell.detailTextLabel?.text = "버스 유형 : 순환"
       }
       else if(cell.detailTextLabel?.text == "6")
       {
           cell.detailTextLabel?.text = "버스 유형 : 광역"
       }
       else if(cell.detailTextLabel?.text == "7")
       {
           cell.detailTextLabel?.text = "버스 유형 : 인천"
       }
       else if(cell.detailTextLabel?.text == "8")
       {
           cell.detailTextLabel?.text = "버스 유형 : 경기"
       }
       else if(cell.detailTextLabel?.text == "9")
       {
           cell.detailTextLabel?.text = "버스 유형 : 폐지"
       }
       else if(cell.detailTextLabel?.text == "0")
       {
           cell.detailTextLabel?.text = "버스 유형 : 공용"
       }
       
       return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchText : URL!
        var newUrl : String!
        if self.searchbar.text != ""{
            searchText = URL(string: self.searchbar.text!.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
            
            newUrl = url + "&strSrch=" + (searchText).absoluteString
            strurl = newUrl
            
            beginParsing()
            SearchBusList.reloadData()
        }
        else {
            strurl = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
            beginParsing()
            SearchBusList.reloadData()
        }
    }
    
    // 입력 시작과 동시에 검색모드 취소(x)할 수 잇게 함
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        var searchText : URL!
        var newUrl : String!
        if self.searchbar.text != ""{
            searchText = URL(string: self.searchbar.text!.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
            
            newUrl = url + "&strSrch=" + (searchText).absoluteString
            strurl = newUrl
            
            self.searchbar.showsCancelButton = true
            beginParsing()
        }
        
        else {
            strurl = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
            self.searchbar.showsCancelButton = true
            beginParsing()
            audioController.playerEffect(name: SoundWin)
            
            let startX: CGFloat = ScreenWidth - 100
            let startY: CGFloat = 100
            let endY: CGFloat = ScreenHeight + 300
            
            let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
            self.view.addSubview(stars)
            self.view.sendSubviewToBack(_: stars)
            
            UIView.animate(withDuration: 3.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {stars.center = CGPoint(x: startX, y: endY)}, completion: {(value:Bool) in stars.removeFromSuperview()})
        }

    }
    
    // 입력 도중 캔슬 시 호출, 텍스트 내용 초기화하고 캔슬버튼 숨기고 키보드 내림
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.showsCancelButton = false
        self.searchbar.text = ""
        self.searchbar.resignFirstResponder()
        audioController.playerEffect(name: SoundDing)
    }
    
    // 키보드의 검색이나 돋보기 아이콘 누르면 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search text : ", self.searchbar.text!)
       
        self.strurl = self.url + "&strSrch=" + self.searchbar.text!
        
        let tempUrl = self.strurl //한글이 들어간 URL 주소
        let tempurl2:URL = URL(string: tempUrl.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        strurl = tempurl2.absoluteString
        
        self.searchbar.showsCancelButton = false
        self.searchbar.text = ""
        self.searchbar.resignFirstResponder()
        
        beginParsing()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInfoView"{
                if let cell = sender as? UITableViewCell{
                    let indexPath = SearchBusList.indexPath(for: cell)
                    if let busInfoViewController = segue.destination as? BusInfoViewController{
                        let busNum = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "busRouteNm")as! NSString as String
                        busInfoViewController.busRouteNm = busNum
                        
                        //busNum_utf8 = busNum.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                        //busInfoViewController.urlStation = busInfoViewController.url + "&strSrch=" + busNum_utf8
                        
                        
                        let busId = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "busRouteId")as! NSString as String
                        busInfoViewController.busRouteId = busId
                        
                        busInfoViewController.urlStation = busInfoViewController.url + "&busRouteId=" + busId
                        
                        let stStation = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "stStationNm")as! NSString as String
                        busInfoViewController.stStationNm = stStation
                        let edStation = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "edStationNm")as! NSString as String
                        busInfoViewController.edStationNm = edStation
                        
                        
                }
            }
        }
    }
}

