//
//  ViewController.swift
//  GPSTest
//
//  Created by Invitado on 22/10/16.
//  Copyright © 2016 Invitado. All rights reserved.
//

import UIKit
//2
import CoreLocation

import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var elMapa: MKMapView!
    //1
    @IBOutlet weak var txtLon: UITextField!
    @IBOutlet weak var txtLat: UITextField!
    
    //declaramos property
    //PRENDER Y APAGAR PARA QUE NO CONSUMA BATERIA
    var localizador:CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //2
        //precision deseada
        self.localizador = CLLocationManager()
        self.localizador?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        //poner el protocolo CLLocationManagerDelegate
        self.localizador?.delegate = self
        
        /* para el xcode 8.?
        let autorizado = CLLocationManager.authorizationStatus()
        if autorizado == CLAuthorizationStatus.NotDetermined{
            self.localizador?.requestWhenInUseAuthorization()
        }
        //requiere llave en info.plist que es la de NSLocationWhenUseUsageDescription
        */
        
        
        //lanza el
        self.localizador?.startUpdatingLocation()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*  3
     *  locationManager:didFailWithError:
     *
     *  Discussion:
     *    Invoked when an error has occurred. Error types are defined in "CLError.h".
     */
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        self.localizador?.stopUpdatingLocation()
        
        if #available(iOS 8.0, *) {
            let ac = UIAlertController(title: "Error", message: "no se pueden obtener lecturas de gsp",     preferredStyle: .Alert)
            let ab = UIAlertAction(title: "so sad...", style: .Default, handler: nil)
            ac.addAction(ab)
        
            self.presentViewController(ac, animated: true, completion: nil)
        }
        else{
            UIAlertView(title: "Mensaje", message: "Todos los campos son requeridos. Por favor, ingréselos.", delegate: nil, cancelButtonTitle: "Aceptar").show()
        }
    
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let ubicacion = locations.last
        self.txtLat.text = "\(ubicacion!.coordinate.latitude)"
        self.txtLon.text = "\(ubicacion!.coordinate.longitude)"
        //TODO: Determinar si se dejan tomar lecturas
        
        //6
        self.colocarMapa(ubicacion!)
    }
    

    //4
    //ponemos en info.plist  el Privacy - Location Usage Description
    
    //5   Colocamos mapa en el storyboard e importamos el mapkit como framework
    //en el mapa, en los atributos, colocar el "shows user location"
    
    func colocarMapa(ubicacion:CLLocation){
        
        //let ubicacionFake = CLLocationCoordinate2D(latitude: 19.322495, longitude: -99.1864588)
        //la de arriba se usa en lugar de laCoordenada
        
        let laCoordenada = ubicacion.coordinate
        let region = MKCoordinateRegionMakeWithDistance(laCoordenada, 1000, 1000)
        //1 Km de radio
        self.elMapa.setRegion(region, animated: true)
        
        //8
        let losPines = self.elMapa.annotations
        self.elMapa.removeAnnotations(losPines)
        let elPin = ElPin(title: "Usted está aquí", subtitle: "", coordinate: laCoordenada)
        self.elMapa.addAnnotation(elPin)
        
    }
    
    //7 quito el show user location para crear mi propio pin, se agrega clase swift file
    
}

