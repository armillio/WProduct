
import Foundation

class MulticastDelegate<T: Any> {
    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    func addDelegate(_ delegate: T) {
        self.delegates.add(delegate as AnyObject)
    }

    func removeDelegate(_ delegate: T) {
        self.delegates.remove(delegate as AnyObject)
    }

    func invokeDelegates(withInvocation invocation: (T) -> Void) {
        self.delegates.allObjects.compactMap { object in
            return object as? T
            }.forEach(invocation)
    }
}
