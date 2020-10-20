pragma solidity 0.5.12;

contract HelloPerson{
    
    struct Person {
        string name;
        uint age;
        uint height;
        bool senior;
    }
     
    // Declare Event with type of data we want to send together with the event
    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);
    
    // Create an event that is called personUpdated. This will be called whenever someone updates their information in the mapping. 
    // It should contain both the new information and the old information.
    event personUpdated(string name, uint age, uint height, bool senior, string, uint, uint, bool );
    
    // variable to set the owner
    address public owner;
    
    // Allows to reduce code repetition, to clarify it and simplify it.
    modifier onlyOwner(){
        require(msg.sender == owner);
        _; // means continue executiion
    }
   
    // constructor is the function that runs whenever the contract is created
    constructor() public{
    // This code will be called only when the contract is created. 
    // the msg.sender in the constructor will be the person that initiates the conctract creation and it will only run ONCE
        owner = msg.sender;
    }
    
    // create a mapping and specify the key type or data type of the key
    mapping(address => Person) private people;
     
    // Add an array only accessible by the contract owner which list 
    // all of the addresses that has been used to create people in the mapping
    address [] private creators;
    
    function createPerson (string memory _name, uint _age, uint _height) public {
        require(_age <= 150, "Age needs to be  below 150");
        
    // This block creates a person with a condition age == 0 that makes sure it is a new entry in the mapping      
        if (people[msg.sender].age == 0){
            
           people[msg.sender].name = _name;
           people[msg.sender].age = _age;
           people[msg.sender].height = _height;
        
           if(_age >= 65) {
               people[msg.sender].senior = true;
           } else {people[msg.sender].senior = false;
           }
    // Calling event personCreated 
            emit personCreated(_name, people[msg.sender].senior);
        
        // This block updates the person
            } else {
                
              string memory oldName = people[msg.sender].name;
              uint oldAge = people[msg.sender].age;
              uint oldHeight = people[msg.sender].height;
              bool oldSenior = people[msg.sender].senior;
              
              people[msg.sender].name = _name;
              people[msg.sender].age = _age;
              people[msg.sender].height = _height;
              
              if(_age >= 65) {
               people[msg.sender].senior = true;
           } else {people[msg.sender].senior = false;
           }
           
        // calling the event personUpdated with the old and new information    
             emit personUpdated(oldName, oldAge, oldHeight, oldSenior, people[msg.sender].name, people[msg.sender].age, people[msg.sender].height, people[msg.sender].senior);  
            }
            
    //  insertPerson(newPerson);
    // Adding peolple to the mapping 
       creators.push(msg.sender);
           }

    // create private function that will run on function createPerson
    function insertPerson (Person memory newPerson) private {
        
        // Create a variable that will give us the address of the sender of the caller of this function 
        address creator = msg.sender; // very important element 
        
       // We don't use push to add elements to the array
       // We add elements or assing an entry to the mapping using the key [creator] that points to value newPerson
        people[creator] = newPerson; 
    }
    
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
       address creator = msg.sender; 
       return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    
    // delete function only accessible to the owner of the contract 
    function deletePerson(address creator) public onlyOwner {
        string memory name = people[creator].name;
        bool senior = people[creator].senior;
        
        delete people[creator];
        // assert here means that the moment we delete a person the age result should be 0
        assert(people[creator].age == 0);
        emit personDeleted(name, senior, msg.sender);
    }
    // getter function to access the private array creators
    function getCreator(uint index) public view onlyOwner returns(address){
        return creators[index];
    }
    
}
