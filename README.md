# Ahoy Movement Studio
## AhoyMap iOS SDK



The AhoyMap iOS SDK is built to provide seamless integration of Map functionalites into your app


## Features

- Display a Map with zoom and pan funtionality
- Add marker to the map
- Remove marker 
- Add a polyline
- Remove a polyline
- Add a polygon
- Remove a polygon
- Set Zoom level of Map
- Show traffic flow
- Show location on Map
- Load custom themes(Day/Night) etc


## Installation

  Signup for **Ahoy Movement Studio** and obtain a **Subscription Key**, you can do so by signing up [here](https://ams.ahoy.technology)
  The **AhoyMap** SDK for iOS can be downloaded through **Cocoapods**
  
  - Install cocoapods on your mac(if you dont have it installed already) by running the following command on the terminal
        ```
    sudo gem install cocoapods
        ```   
- Once the cocoapods on installed navigate to the project directory and create a pod by running the following command in the terminal
       ```
    pod init
        ``` 
- Open the  file in text editor and add the spec source at the top and the pod name  

    ```
    source 'https://github.com/CocoaPods/Specs' 
        target 'TestApp' do
        use_frameworks!
            # Pods for App
            pod 'AhoyMap'
        end
    ``` 
- Now open the terminal and run the following command in the terminal

     ```
      pod install
     ``` 

## Usage
- Open **AppDelegate** file of your project and add the following

    ```
      import AhoyMap
    ``` 
- Add the SDK initialisation function in the **didFinishLaunchingWithOptions** function of the **AppDelegate**, the SDK can be initialised through this function

    ```
       AhoySDKManager.shared()
            .ahoySDKKey("YOUR_AMS_SUBSCRIPTION_KEY")
            .headerBackgroundColor(.blue)
            .footerBackgroundColor(.white)
            .footerAccentColor(.black) //foreground color
            .headerAccentColor(.white)
            .setAhoyMapKitDelegate(self)
            .build()
    ```
- Conform to the **AhoySDKManagerDelegate** in App delegate by doing so

    ```
    extension AppDelegate : AhoySDKManagerDelegate {
        func didFailtoInitialiseAhoyMapKitSDK(error: Error) {
            print("AHOY MAPKIT SDK initialisation failed \(error)")
        }

        func didInitialiseAhoyMapKitSDK() {
            print("AHOY MAPKIT SDK initialisation successfull")
        }
    }
    ```
- Now run the app, you should see the AHOY MAPKIT SDK initialisation successfull message in the xcode console.

## Display a Map
- Open the info.plist and make sure you have location usage permissions by adding NSLocationWhenInUseUsageDescription key.
- There are two ways of displaying a map on the ViewController
  - **IBDesignable**
    - Please note if your current ViewController is not the rootViewController(not the initial controller) of your app, only then you can use this option, becuase the AhoyMap SDK initialisation is an async process and you need to make sure AhoyMap is initialised, if your view controller is not the root view controller you can simply do these steps
      - Drag and drop a UIView on to the xib/storyboard
      - Select the Identity Inspector and set the Custom Class to **AhoyMapView** and module to **AhoyMap**
      - Create an @IBOutlet and link it to your ViewController
  - **Programatically**
      - if your ViewController where you intend to show Map is a rootViewController(initial view controller) you will have to post a notification from **AhoySDKManagerDelegate**'s  **didInitialiseAhoyMapKitSDK** function to notify the ViewController about SDKs initialisation and then add the Map programatically, please have a look at the example apps implementation for more details.
      
         ```
           let mapView = AhoyMapView()
            mapView.frame = self.view.frame
            mapContainerView.addSubview(mapView)
        ```

## Add Polyline to the Map
- Make sure you have added AhoyMapView either through IBDesignable or through code and add the following function

    ```
        do {
            let geoCoordinatesArray = [
                CLLocationCoordinate2D(latitude: 25.308147142589714, longitude: 55.37651267478113),
                CLLocationCoordinate2D(latitude: 25.311452472079345,  longitude: 55.379549601333615)
            ]
            polyline = Polyline(coordinates: geoCoordinatesArray, lineWidth: 30, lineColor: .red)
            guard let polyline = polyline else {
                return
            }
            try ahoyMapView.addPolyLine(model: polyline)

        } catch let error {
            print("could not add polyline \(error.localizedDescription)")
        }
    ```
- You should now see a polyline on your map passing through the given coordinates

## Removing a polyline from the Map
- Removing a polyline is fairly straight forward, we just need to makesure to pass the same model which was passed while adding the polyline

    ```
        ahoyMapView.removePolyline(model: polyline)
    ```

## Add Polygon to the Map
- You can add a polygon on the map by using **addPolyLine** function of the AhoyMapView, sample implementation is as follows

    ```
          let geoCoordinatesArray = [
              CLLocationCoordinate2D(latitude: 25.30608803938275,  longitude: 55.374215000171795),
              CLLocationCoordinate2D(latitude: 25.308147142589714, longitude: 55.37651267478113),
              CLLocationCoordinate2D(latitude: 25.311452472079345,  longitude: 55.379549601333615)
          ]
         let polygon = Polygon(coordinates: geoCoordinatesArray, color: .red)
            do {
                try mapView.addPolygon(polygon: polygon)
            } catch let error {
                print("could not add polygon \(error.localizedDescription)")
            }
    ```
## Remove a polygon from Map
- Removing a polygon is fairly straight forward, we just need to makesure to pass the same model which was passed while adding the polygon

    ```
        mapView.removePolygon(polygon: polygon)
    ```
## Add Marker to the Map
- The marker can be added to the map using the **addMarker** function of the AhoyMapView, the sample implementation is as follows

    ```
      let markerCoordinates = CLLocationCoordinate2D(latitude: 25.302506048147787, longitude: 55.375242494744285)
      let marker = Marker(coordinates: test, image: UIImage(named: "pin"))
      do {
          try mapView.addMarker(marker: marker)
      } catch let error {
          print("error is \(error)")
      }
    ```

## Remove the marker
- A marker can be removed from the map using the **removeMarker** function, we just need to makesure to pass the same model which was passed while adding the marker

    ```
        mapView.removeMarker(marker: marker)
    ```

## Set Zoom Level of Map
- The Zoom level of map can be set within the range [0-22] using the **setZoomLevel** function

    ```
        mapView.setZoomLevel(level: 22)
    ```
    
## Toggle traffic flow on the Map
- The traffic flow on the map can be enabled/disabled using the **showTrafficFlow** as follows

    ```
        mapView.showTrafficFlow(isTrafficOn: true)
    ```
    
## Show certain location on the Map
- If you wanted to show a certain location on the map that can be done using the **moveCamera** function as follows

    ```
        let locationCoordinates = CLLocationCoordinate2D(latitude: 25.302506048147787, longitude: 55.375242494744285)
        mapView.moveCamera(coordinates: locationCoordinates)
    ```
    
## Set Map Scheme for Map
- AhoyMap supports wide range of map schemes those can be set using the **setMapScheme** as follows

    ```
      mapView.setMapScheme(scheme: .satellite)
    ```

## **EXAMPLES**
- The Examples Apps with of all the AhoyMap functions can be downloaded through this [Link](https://iossdk.blob.core.windows.net/iossdk/AMS-iOS-Examples.zip)
