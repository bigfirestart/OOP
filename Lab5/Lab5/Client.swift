struct Client {
    private(set) var firstName: String
    private(set) var secondName: String
    private(set) var adress: Adress? = nil
    private(set) var passportNumber: Int? = nil
    
    init(firstName: String, secondName: String){
        self.firstName = firstName
        self.secondName = secondName
    }
}

struct Adress {
    private(set) var country: String
    private(set) var city: String
    private(set) var street: String
    private(set) var building: Int
}
