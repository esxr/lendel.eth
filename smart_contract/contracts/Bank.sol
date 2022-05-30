// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract Bank {
    // initialize user -> balance mapping
    mapping(address => uint) balances;

    // get balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // depost money
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // withdraw money
    function withdraw(uint _amount) public {
        // check if enough in the bank account
        require(balances[msg.sender] >= _amount, "Not enough balance");

        // withdraw and give to the sender
        balances[msg.sender] -= _amount;
        (bool sent,) = msg.sender.call{value: _amount}("sent");
        require(sent, "Failed to complete");
    }
}