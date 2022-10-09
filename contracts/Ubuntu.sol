//SPDX-License-Identifier: MIT
//WITHOUT USING OPENZEPPELIN

pragma solidity ^0.8.17;

contract Ubuntu {
    string private name;
    string private symbol;
    uint256 private totalSupply;
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    constructor() {
        name = "Ubuntu";
        symbol = "UBU";
        totalSupply = 1000000000000000000000; //1000 Ubuntu, 1000*10**18 Wei Ubuntu
        balances[msg.sender] = totalSupply;
    }

    //from IERC20Metadata.sol

    function getName() public view returns (string memory) {
        return name;
    }

    function getSymbol() public view returns (string memory) {
        return symbol;
    }

    //from IERC20.sol

    event Transfer(address indexed _from, address indexed _to, uint256 _amount);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _amount
    );

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function getBalance(address _account) public view returns (uint256) {
        uint256 _balance = balances[_account];
        return _balance;
    }

    //returns amount _spender can use from _owner's account.
    function getAllowance(address _owner, address _spender)
        public
        view
        returns (uint256)
    {
        return allowances[_owner][_spender];
    }

    //caller sends _amount Ubuntu to _to.
    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(
            balances[msg.sender] >= _amount,
            "Insufficinet funds to transfer"
        );
        require(msg.sender != address(0), "Sender cannot be zero address");
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = balances[_to] + _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    //caller provides _amount allowance to _spender.
    function approve(address _spender, uint256 _amount) public returns (bool) {
        require(msg.sender != address(0), "Owner cannot be zero address");
        require(_spender != address(0), "Spender cannot be zero address");
        allowances[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    //transfers _amount Ubuntu on behalf of _owner
    function transferFrom(
        address _owner,
        address _spender,
        uint256 _amount
    ) public returns (bool) {
        require(
            allowances[_owner][_spender] >= _amount,
            "Insufficient allowance"
        );
        balances[_owner] = balances[_owner] - _amount;
        balances[_spender] = balances[_spender] + _amount;
        allowances[_owner][_spender] = allowances[_owner][_spender] - _amount;
        emit Transfer(_owner, _spender, _amount);

        return true;
    }
}
