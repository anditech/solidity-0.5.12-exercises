

// From Destroyable contract 

import "./Ownable.sol";
pragma solidity 0.5.12;

contract Destroyable is Ownable { // we  inherit the code needed from contract Ownable
    
function destroyContract() public onlyOwner { // The modifier we set up in contract Ownable 
    selfdestruct(msg.sender); // destruction can be achieved only by the owner 
}
  
 // From HelloPerson contract 
  
import "./Ownable.sol";
import "./Destroyable.sol"; // allow us to destroy HelloPerson contract
pragma solidity 0.5.12;

contract HelloPerson is Ownable, Destroyable {
  
