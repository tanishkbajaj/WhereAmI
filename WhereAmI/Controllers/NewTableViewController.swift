import UIKit
import MapKit
import GoogleMobileAds

class NewTableViewController: UITableViewController, GADInterstitialDelegate,GADBannerViewDelegate, UIAlertViewDelegate {
    
    var storedLocations : [Location] = CoreDatabase.fetchLocations()
    var getCurrLocation: Location = Location()
    var interstitial: GADInterstitial!
    var distanceArray : [Double] = []
    var distanceArr : [Distance] = []
    var segmentedControllerStoredValue = UserDefaults.standard.integer(forKey: "value")
    
    var tableViewFlag : Bool = false
    
    
    
    
  //  @IBOutlet weak var bannerTableView: GADBannerView!
    var segmentedController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibName = UINib(nibName: "HistoryItemsTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HistoryItemsTableViewCell")
        tableView.rowHeight = 80
        
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50;
        
        
        let items = ["Mi", "Km"]
        segmentedController = UISegmentedControl(items: items)
        segmentedController.selectedSegmentIndex = 0
        
    
        
        getDistanceArray()
        
        //For Ads
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
//
//        let request = GADRequest()
//        interstitial.load(request)
//        interstitial.delegate = self
//
//        bannerTableView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        bannerTableView.rootViewController = self
//        bannerTableView.load(GADRequest())
//        bannerTableView.delegate = self
//        bannerTableView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//
//            self.interstitial.present(fromRootViewController: self)
//        })
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (storedLocations.count)
    }
    
   
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryItemsTableViewCell", for: indexPath) as! HistoryItemsTableViewCell
        
      
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MM/dd/yy"
        
        
        cell.LocationNameLabel.text = storedLocations.reversed()[indexPath.row].address
        

        cell.DateLabel.text = dateFormatter.string(from: storedLocations.reversed()[indexPath.row].date)
        
        if distanceArray.count == storedLocations.count {
            distanceArr = distanceArr.sorted(by: { $0.date > $1.date })
            
            var DistanceLabel = ""
            switch segmentedController.selectedSegmentIndex
            {
            case 0:
                DistanceLabel =  String(distanceArr[indexPath.row].toFormattedMile()) + " Mi away"
            case 1:
                DistanceLabel =  String(distanceArr[indexPath.row].toFormattedKilo()) + " Km away"

            default:
                DistanceLabel = "NA"
            }
            
            if distanceArr[indexPath.row].distance < 0 {
                DistanceLabel = "NA"
            }
            cell.DistanceLabel.text = DistanceLabel
           // cell.DistanceLabel.text = "1386.43 Mi away"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        

            let headerView:UIView = UIView()
            headerView.frame = CGRect(x : 0, y: 0, width: tableView.frame.width, height: 0)

            
        
            segmentedController.addTarget(self, action: #selector(indexChanged(_ :)), for: .valueChanged)
            segmentedController.frame = CGRect(x: 280, y: 10, width: 75, height: 30)
        
            segmentedController.selectedSegmentIndex = segmentedControllerStoredValue
        
            headerView.addSubview(segmentedController)
            return headerView
        
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl)
    {
        if segmentedControllerStoredValue != 1 {
            segmentedControllerStoredValue = 1
        } else {
            segmentedControllerStoredValue = 0
        }
        UserDefaults.standard.set(segmentedControllerStoredValue, forKey: "value")
        self.tableView.reloadData()
    }
    
    
    func getDistanceArray() {
        
        let group = DispatchGroup()
        
        for index in 0...storedLocations.count-1{
            group.enter()
            DistanceCalculator.routingDistance(getCurrLocation, storedLocations.reversed()[index]) { distance in
                self.distanceArray.append(distance)
                self.distanceArr.append(Distance(distance: distance, date: self.storedLocations.reversed()[index].date))
                self.tableViewFlag = true
                self.tableView.reloadData()
                
                group.leave()
            }
        }
        
        //  group.wait()
        
        if tableViewFlag == true {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: getCurrLocation.latitude , longitude: getCurrLocation.longitude)))
        source.name = "My Location"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: storedLocations.reversed()[indexPath.row].latitude, longitude: storedLocations.reversed()[indexPath.row].longitude)))
        
        destination.name = storedLocations.reversed()[indexPath.row].address
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            //self.storedLocations.remove(at: indexPath.row)
            
            
            
            var temporaryArray = Array(self.storedLocations.reversed())
            CoreDatabase.deleteLocation(temporaryArray[indexPath.row])
            temporaryArray.remove(at: indexPath.row)
            
            self.storedLocations = Array(temporaryArray.reversed())
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        let share = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            
            let alert = UIAlertController(title: "Edit Address", message: "Change Address Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.text = self.storedLocations.reversed()[indexPath.row].address
            })
            
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
                
                if let address = alert.textFields?.first?.text {
                    var temporaryArray = Array(self.storedLocations.reversed())
                    temporaryArray[indexPath.row].address = address
                    CoreDatabase.updateLocation(temporaryArray[indexPath.row])
                    self.storedLocations = Array(temporaryArray.reversed())
                    tableView.reloadData()
                }
                
                
                let alert = UIAlertController(title: "Changed!", message: "You have edited the address", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                
                self.present(alert, animated: true)
            }))
            
            self.present(alert, animated: true)
            
        }
        
        share.backgroundColor = UIColor.lightGray
        
        return [delete, share]
        
    }
    


}
