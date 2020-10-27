import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People {
    
    // Mapping that points each workers address to his salary
     mapping(address => uint) public salary;
    // Mapping that points each workers address to his boss
     mapping(address => address) public bossOf;
     
    // Function createWorker as a wrapper function for createPerson, adding the extra necessary arguments to 
    // create a worker such as: _salary, _address boss and _addres worker
    function createWorker(string memory _name, uint _age, uint _height, uint _salary, address _boss, address _worker) public {
        // the worker can not be over 75 years of age
        require(_age <= 75);
        // calling createPerson function to create worker    
        createPerson( _name, _age, _height);
        // Setting the salary for the worker in salary Mapping   
        salary[_worker] = _salary;
        // Setting the boss of a worker in bossOf Mapping    
        bossOf[_worker] = _boss;
    }  
    //  Implement a fire function, which removes the worker from the contract.     
    function fireWorker(address _worker) public {
         // Only the boss can fire his worker    
        require (msg.sender == bossOf[_worker]);
        // Call to deletePerson function to fire worker    
        deletePerson(_worker);
        // When firing worker we delete his salary    
        delete(salary[_worker]);
        // When firing worker we delete his boss
        delete(bossOf[_worker]);
    }
    
}
