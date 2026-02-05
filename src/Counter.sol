// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    address public owner;

    error Decrement_Underflow();
    
    constructor() {
        owner = msg.sender;
    }

    function setNumber(uint256 newNumber) public {
        require(msg.sender == owner, "Only owner can set the number");
        number = newNumber;
        emit NumberChanged(newNumber, msg.sender);
    }

    function increment() public {
        number++;
    }

    function decrement() public {
        if (number == 0) {
            revert Decrement_Underflow();
        }
        number--;
    }

    function getNumber() public view returns (uint256) {
        return number;
    }

    event NumberChanged(uint256 indexed newNumber, address updatedBy);
}
