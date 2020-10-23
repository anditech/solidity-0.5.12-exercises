import "./Ownable.sol";
import "./Destroyable.sol"; // allow us to destroy HelloPerson contract
pragma solidity 0.5.12;

contract People is Ownable, Destroyable {
    
    struct Person {
        string name;
        uint age;
        uint height;
        bool senior;
    }
    
    // Declare Event with type of data we want to send together with the event
    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);
    
    // variable to track balance
    uint public balance;
    
    // create a cost modifier
    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }
   
    // create a mapping and specify the key type or data type of the key
    mapping(address => Person) private people;
     
    /* Add an array only accessible by the contract owner which list 
       all of the addresses that has been used to create people in the mapping
    */   
    address [] private creators;
    
    
    // This function will charge ETH to create a person => add keyword "payable" 
    function createPerson (string memory name, uint age, uint height) public payable costs(100 wei) {
        require(age <= 150, "Age needs to be  below 150");
        
        balance += msg.value; // balance = balance + msg.value
        
    // This creates a person     
       Person memory newPerson;
       newPerson.name = name;
       newPerson.age = age;
       newPerson.height = height;
       
    // Creates a condition to know if the person is a senior or not
       if(age >= 65) {
           newPerson.senior = true;
       }
       else {
           newPerson.senior = false;
       }
       insertPerson(newPerson);
       creators.push(msg.sender);
       
    // here we use assert to compare that people[msg.sender] == newPerson and we need to encode both  hashing them
       assert(
           keccak256(
               abi.encodePacked(
                   people[msg.sender].name, 
                   people[msg.sender].age, 
                   people[msg.sender].height, 
                   people[msg.sender].senior 
                )
            ) == 
            keccak256(
                abi.encodePacked(
                    newPerson.name, 
                    newPerson.age, 
                    newPerson.height, 
                    newPerson.senior
                )
            )
        );
        
        // Emit event with the data we want to send with it
        emit personCreated(newPerson.name, newPerson.senior);
 
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
    
    function withdrawAll() public onlyOwner returns(uint) {
        uint toTransfer = balance;
        balance = 0;
        msg.sender.transfer(toTransfer); // if transfer fails this will revert
        return toTransfer;
        
     //   uint toTransfer = balance;
     //   balance = 0;
     //   if(msg.sender.send(toTransfer); // if transfer fails this returns false but Tx won't revert
     //   return toTransfer;
        
        
        
    }
    
}
