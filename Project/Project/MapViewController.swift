//
//  MapViewController.swift
//  Project
//
//  Created by kpugame on 2019. 6. 3..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,  MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var posts = NSMutableArray()
    
    let regionRadius: CLLocationDistance = 5000
    
    var url : String = "http://ws.bus.go.kr/api/rest/busRouteInfo/getRoutePath?serviceKey=cO%2FgfssMFJwbeb6AJkxR1QzaSAtqPrpkZr887lmaOnjLhYAuF4KCZgL9TUNI5DWXv0EQ5xA3nbWi9adgvFsGLw%3D%3D"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 37.5384514, longitude: 127.0709764)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        
        loadInitialData()
        mapView.addAnnotations(busStations)
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }

    var busStations : [BusStation] = []
    
    func loadInitialData() {
        for post in posts {
            let busRouteId: String = (post as AnyObject).value(forKey: "busRouteId") as! String
            let direction: String =  (post as AnyObject).value(forKey: "direction") as! NSString as String
            let beginTm: String =  (post as AnyObject).value(forKey: "beginTm") as! NSString as String
            let lastTm: String = (post as AnyObject).value(forKey: "lastTm") as! NSString as String
            let station: String =  (post as AnyObject).value(forKey: "station") as! NSString as String
            let stationNm: String =  (post as AnyObject).value(forKey: "stationNm") as! NSString as String
            let stationNo: String =  (post as AnyObject).value(forKey: "stationNo") as! NSString as String
            let transYn: String =  (post as AnyObject).value(forKey: "transYn") as! NSString as String
            
            let XPos = (post as AnyObject).value(forKey: "XPos") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "YPos") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let busStation = BusStation(busRouteId: busRouteId, direction: direction, beginTm: beginTm, lastTm: lastTm, station: station, stationNm: stationNm, stationNo: stationNo, transYn: transYn, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            busStations.append(busStation)
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
