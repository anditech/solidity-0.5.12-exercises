import "./People.sol";
pragma solidity 0.5.12;


contract Workers is People {
    
     mapping(address => uint) public salary;
     
    function createWorker(string memory _name, uint _age, uint _height, uint _salary) public {
        require(_age <= 75);
        
        createPerson( _name, _age, _height);
        salary[msg.sender] = _salary;
        
    }  
     
     
}
