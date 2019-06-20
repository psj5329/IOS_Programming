//
//  StationMapViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 17..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit
import MapKit

class StationMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var posts = NSMutableArray()
    
    let regionRadius: CLLocationDistance = 5000
    var initialLocation = CLLocation(latitude: 37.5384514, longitude: 127.0709764)
    
    var busStations : [BusStation] = []
    
    var url : String = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadInitialData()
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        
        mapView.addAnnotations(busStations)
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        for post in posts {
            let stationNo = (post as AnyObject).value(forKey: "stationNo") as! NSString as String
            let stationNm = (post as AnyObject).value(forKey: "stationNm") as! NSString as String
            let beginTm = (post as AnyObject).value(forKey: "beginTm") as! NSString as String
            let lastTm = (post as AnyObject).value(forKey: "lastTm") as! NSString as String
            let posX = (post as AnyObject).value(forKey: "posX") as! NSString as String
            let posY = (post as AnyObject).value(forKey: "posY") as! NSString as String
            let lat = (posY as NSString).doubleValue
            let lon = (posX as NSString).doubleValue
            let busStation = BusStation(stationNm: stationNm, stationNo: stationNo, beginTm: beginTm, lastTm: lastTm, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
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
