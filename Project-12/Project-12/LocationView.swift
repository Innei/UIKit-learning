//
//  LocationView.swift
//  Project-12
//
//  Created by Innei on 2021/2/19.
//

import CoreLocation
import SwiftUI

class LocationObserver: ObservableObject {
    @Published var text: String = ""
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    public var data = LocationObserver()
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("OK!!")
        data.text = "OK!!"
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
                }
            }
        }
    }

//    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//        if beacons.count > 0 {
//            let beacon = beacons[0]
//            update(distance: beacon.proximity)
//        } else {
//            update(distance: .unknown)
//        }
//    }
}

struct LocationView: View {
    let locationManagerDelegate = LocationManagerDelegate()
    let locationManager: CLLocationManager?
    @ObservedObject var data: LocationObserver = LocationObserver()
    var body: some View {
        VStack {
            Text("UNKOWNED")
            Text(data.text)
        }
    }

    init() {
        locationManager = CLLocationManager()
        locationManager?.delegate = locationManagerDelegate
        locationManager?.requestAlwaysAuthorization()
        data = locationManagerDelegate.data
    }

    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")

        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }

    func update(distance: CLProximity) {
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
