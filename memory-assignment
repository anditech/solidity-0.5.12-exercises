pragma solidity 0.5.12;
contract MemoryAndStorage {

        // State variables
    mapping(uint => User) users;

    struct User{
        uint id;
        uint balance;
    }
    
     // this function adds a user to the mapping taking uint id & uint balance as arguments 
    function addUser(uint id, uint balance) public {
         users[id] = User(id, balance);
    }
    // this function takes uint id & uint balance as arguments and updates balance
    function updateBalance(uint id, uint balance) public {
        // we can update balance by changing it directly in the mapping 
        users[id].balance = balance;
        
      // When we have data location "memory"  the balance is not permanently stored and won't be updated.
      // we need to change data location to "storage" to be able to update any changes in User struct 
      //  User storage user = users[id];
      //  user.balance = balance;
      
    }
  
    // this function takes uint id as argument and returns balance of user 
    function getBalance(uint id) view public returns (uint) {
        return users[id].balance;
    }

}
