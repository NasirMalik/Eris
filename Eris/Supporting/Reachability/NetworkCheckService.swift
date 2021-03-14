/*
 Credits: https://www.hackingwithswift.com/example-code/networking/how-to-check-for-internet-connectivity-using-nwpathmonitor
 */

import Foundation
import Network

protocol NetworkCheckObserver: class {
    func statusDidChange(status: NWPath.Status)
}

final class NetworkCheckService {
    
    struct NetworkChangeObservation {
        weak var observer: NetworkCheckObserver?
    }
    
    private var monitor = NWPathMonitor()
    private var queue = DispatchQueue(label: "Monitor")
    private var observations = [ObjectIdentifier: NetworkChangeObservation]()
    
    var currentStatus: NWPath.Status {
        get {
            return monitor.currentPath.status
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { [unowned self] path in
            for (id, observations) in self.observations {
                guard let observer = observations.observer else {
                    self.observations.removeValue(forKey: id)
                    continue
                }
                
                DispatchQueue.main.async {
                    observer.statusDidChange(status: path.status)
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    func addObserver(observer: NetworkCheckObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = NetworkChangeObservation(observer: observer)
    }
    
    func removeObserver(observer: NetworkCheckObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
    
}
