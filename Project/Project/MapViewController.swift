//
//  MapViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 3..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,  MKMapViewDelegate, XMLParserDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var posts = NSMutableArray()
    var parser = XMLParser()
    var elements = NSMutableDictionary()
    var element = NSString()
    var busRouteId = NSMutableString()
    var direction = NSMutableString()
    var beginTm = NSMutableString()
    var lastTm = NSMutableString()
    var station = NSMutableString()
    var stationNo = NSMutableString()
    var stationNm = NSMutableString()
    var transYn = NSMutableString()
    var posX = NSMutableString()
    var posY = NSMutableString()
    
    let regionRadius: CLLocationDistance = 5000
    var initialLocation = CLLocation(latitude: 126.4337666326, longitude: 37.4661678512)
    
    var url : String = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
        loadInitialData()
        
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        mapView.addAnnotations(busStations)
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        //SearchBusList.reloadData()
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }

    var busStations : [BusStation] = []
    
    /*func loadInitialData() {
        for post in posts {
            //busRouteId = (post as AnyObject).value(forKey: "busRouteId") as! String as! NSMutableString
            //direction =  (post as AnyObject).value(forKey: "direction") as! String as! NSMutableString
            beginTm =  (post as AnyObject).value(forKey: "beginTm") as! String as! NSMutableString
            lastTm = (post as AnyObject).value(forKey: "lastTm") as! String as! NSMutableString
            //station =  (post as AnyObject).value(forKey: "station") as! String as! NSMutableString
            stationNm =  (post as AnyObject).value(forKey: "stationNm") as! String as! NSMutableString
            stationNo =  (post as AnyObject).value(forKey: "stationNo") as! String as! NSMutableString
            //transYn =  (post as AnyObject).value(forKey: "transYn") as! String as! NSMutableString
            
            posX = (post as AnyObject).value(forKey: "posX") as! String as! NSMutableString
            posY = (post as AnyObject).value(forKey: "posY") as! String as! NSMutableString
            let lat = (posX as NSString).doubleValue
            let lon = (posY as NSString).doubleValue
            let busStation = BusStation(stationNm: stationNm as String, stationNo: stationNo as String, beginTm: beginTm as String, lastTm: lastTm as String, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            busStations.append(busStation)
            
            initialLocation = CLLocation(latitude: lat, longitude: lon)
        }
    }*/
    func loadInitialData() {
        for post in posts {
            stationNo = (post as AnyObject).value(forKey: "stationNo") as! String as! NSMutableString
            stationNm = (post as AnyObject).value(forKey: "stationNm") as! String as! NSMutableString
            beginTm = (post as AnyObject).value(forKey: "beginTm") as! String as! NSMutableString
            lastTm = (post as AnyObject).value(forKey: "lastTm") as! String as! NSMutableString
            posX = (post as AnyObject).value(forKey: "posX") as! String as! NSMutableString
            posY = (post as AnyObject).value(forKey: "posY") as! String as! NSMutableString
            let lat = (posY as NSString).doubleValue
            let lon = (posX as NSString).doubleValue
            let busStation = BusStation(stationNm: stationNm as String, stationNo: stationNo as String, beginTm: beginTm as String, lastTm: lastTm as String, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            busStations.append(busStation)
            
            initialLocation = CLLocation(latitude: lat, longitude: lon)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! BusStation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard let annotation = annotation as? BusStation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
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
