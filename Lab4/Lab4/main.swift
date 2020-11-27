import Foundation

let path1 = "ITMO/OOP/Lab4/Files/1.txt"
let path2 = "ITMO/OOP/Lab4/Files/2.txt"
let folder = "ITMO/OOP/Lab4/Files/"

var backup = Backup()

var rp1 = RestorePoint()

try rp1.addFolderFiles(path: folder)

try backup.commitRestorePoint(point: rp1)

let dateFilter = DateFilter()


