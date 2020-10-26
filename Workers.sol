import "./People.sol";
pragma solidity 0.5.12;


contract Workers is People {
    
     mapping(address => uint) public salary;
          
    // createWorker function which is a wrapper function for the createPerson function 
    function createWorker(string memory _name, uint _age, uint _height, uint _salary) public payable costs (100 wei) {
        require(_age <= 75);
        createPerson( _name, _age, _height);
        salary[msg.sender] = _salary;
        bosses.push(msg.sender);
    }  
    //  Implement a fire function, which removes the worker from the contract.     
    function fireWorker(address _worker) public {
        deletePerson(_worker);
    }
        
    }
