pragma solidity 0.5.12;

contract HelloPerson{
    
    // Modify the Player struct and add an address property Creator.
    struct Player {
        uint id;
        string name;
        uint age;
        uint height;
        address creator;
        
    }
    // Instead of having a mapping where we store people, create a new array where we can store the people. 
    // When someone creates a new person, add the Person object to the people array instead of the mapping.
    
    Player[] public people;
    
    //Make sure to edit the createPlayer function so that it sets this property to the msg.sender.
    function createPlayer(string memory name, uint age, uint height) public {
        
        // This creates a player    
       Player memory newPlayer;
       newPlayer.id = people.length;
       newPlayer.name = name;
       newPlayer.age = age;
       newPlayer.height = height;
       newPlayer.creator = msg.sender;
       people.push(newPlayer);
        
    }
    
    // Create a public get function where we can input an index and retrieve the Player object with that index in the array.
   function getPlayer(uint index) public view returns(string memory name, uint age, uint height){
        
    return (people[index].name, people[index].age, people[index].height);
 }
 
    
}
