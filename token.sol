pragma solidity 0.5.12;
import "./Ownable.sol";


contract ERC20 is Ownable {

    mapping (address => uint256) private _balances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

        constructor () public {
        _name = "Omnia";
        _symbol = "OMNIA";
        _decimals = 18;
    }


    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;

    }

    function decimals() public view returns (uint8) {
        return _decimals;

    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;

    }
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];

    }

    function mint(address _account, uint256 _amount) public onlyOwner {
        require(_account != address(0)); 
        _balances[_account] = _balances[_account] + _amount;
        _totalSupply = _totalSupply + _amount;

    }

    function transfer(address _recipient, uint256 _amount) public returns (bool) {
        require(msg.sender != address(0), "Caller can not be Account 0");
        require(_recipient != address(0), "Recipient can not be Addres 0");
        require(_balances[msg.sender] >= _amount, "Insufficient balance");
        
        _balances[msg.sender] = _balances[msg.sender] - _amount; 
        _balances[_recipient] = _balances[_recipient] + _amount;
        return true; 
        
    }
}
