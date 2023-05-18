import UIKit

/*
 
 Observer - Наблюдатель
 
 */

//Тип, которому должны соответстоввать все наюлюдатели
protocol Observer {
    func getNew(video: String)
}

//Тип, которому соответствует наблюдаемый субьект
protocol Subject {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notification(video: String)
}

//Класс субьекта

class Bloger: Subject {
    
    var observers = NSMutableSet() /* NSMutableSet - простое множество, в которое мы может добавлять любых наблюдателей, котрые подписаны под NSObject и удалять любых наблюдателей которые подписаны под NSObject */
    
    var video: String = "" {
        didSet { /* didSet - отвечает за наблюдение за свойством */
            notification(video: video)
        }
    }
    
    func add(observer: Observer) {
        observers.add(observer)
    }
    
    func remove(observer: Observer) {
        observers.remove(observer)
    }
    
    func notification(video: String) {
        for observer in observers {
            (observer as! Observer).getNew(video: video)
        }
    }
}

//Классы наблюдателей

class Subscriber: NSObject, Observer {
    
    var nickName: String
    
    init(nickName: String) {
        self.nickName = nickName
    }
    
    func getNew(video: String) {
        print("User \(nickName) got new video \(video)")
    }
}

class Google: NSObject, Observer {
    func getNew(video: String) {
        print("Video \(video) is processing")
    }
}

let vasya = Subscriber(nickName: "Vasy0k")
let fedya = Subscriber(nickName: "Fed0s")
let google = Google()

let vlad = Bloger()
vlad.add(observer: vasya)
vlad.add(observer: fedya)
vlad.add(observer: google)

vlad.video = "Pattern Observer"

vlad.remove(observer: fedya)
vlad.video = "TastyCourse 18"
