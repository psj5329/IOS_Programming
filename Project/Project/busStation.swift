//
//  busStation.swift
//  Project
//
//  Created by kpugame on 2019. 6. 17..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class BusStation: NSObject, MKAnnotation{
    //let busRouteId: String  // 노선 id
    //let direction: String   // 방향(다음 정류장)
    let beginTm: String     // 첫 차 시간
    let lastTm: String      // 막 차 시간
    //let station: String     // 정류장 id
    let stationNm: String   // 정류장 이름
    let stationNo: String   // 정류장 고유 번호
    //let transYn: String     //
    //let busRouteNm: String  // 버스 번호
    //let routeType: String   // 버스 종류
    //let sectSpd: String     //
    //let section: String     // 구간 id
    //let seq: String         // 순번?
    //let trnstnId: String    //
    
    var coordinate: CLLocationCoordinate2D  // 좌표
    
    //init(busRouteId: String, direction: String, beginTm: String, lastTm: String, station: String, stationNm: String, stationNo: String, transYn: String, coordinate: CLLocationCoordinate2D) {
    init(stationNm: String, stationNo: String, beginTm: String, lastTm: String, coordinate: CLLocationCoordinate2D) {
        //self.busRouteId = busRouteId
        //self.direction = direction
        self.beginTm = beginTm
        self.lastTm = lastTm
        //self.station = station
        self.stationNm = stationNm
        self.stationNo = stationNo
        //self.transYn = transYn
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return stationNo
    }
    
    func mapItem() -> MKMapItem{
        let addreassDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addreassDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = stationNm
        return mapItem
    }
}
