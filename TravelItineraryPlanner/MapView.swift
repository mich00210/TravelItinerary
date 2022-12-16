//
//  MapView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 9/12/2022.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct RouteSteps: Identifiable {
    let id = UUID()
    let step: String
}

struct MapView: View {
    @State private var home =  CLLocationCoordinate2D(latitude: 40.748440, longitude: -73.985664)
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.748440, longitude: -73.985664), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)) // latMeters and longMeters or span -> zoom level
    
    @State private var locEntered: String = ""
    @State var routeSteps: [RouteSteps] = [RouteSteps(step: "Enter a destination")]
    
    @State var annotations = [Location(name: "Empire State Building", coordinate: CLLocationCoordinate2D(latitude: 40.748440, longitude: -73.985664))]
    
    var body: some View {
        VStack {
            HStack {
                TextField("Where?", text: $locEntered)
                Button(action: {findNewLocation()}){
                    Text("Go!")
                }.padding(5)

                
            }
            Map(coordinateRegion: $region, annotationItems: annotations) { item in
                MapMarker(coordinate: item.coordinate)
            }//drop pins
                .frame(width: 400, height: 300)
            
            List(routeSteps, id: \.id) { r in
                Text(r.step)
            }
            
        }
    }
    
    func findNewLocation() {
        let locEnteredText = locEntered
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(locEnteredText) { (placemarks, error) -> Void in
            
            if error != nil {
                print("error at geocode")
            }
            
            if let placemark = placemarks?.first {
                let coordinate = placemark.location!.coordinate
                
                region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                
                annotations.append(Location(name: placemark.name!, coordinate: coordinate))
                
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: home))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
                
                request.requestsAlternateRoutes = true
//                request.transportType = .transit
                
                let directions = MKDirections(request: request)
                directions.calculate { response, error in
                    
                    guard let routes = response?.routes else {
                        print("no routes found")
                        return
                    }
                    
                    for route in routes {
                        
                        self.routeSteps = []
                        for step in route.steps {
                            self.routeSteps.append(RouteSteps(step: step.instructions))
                        }
                    }
                }
            }
            
            
            
            // make list
            
            
            
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
