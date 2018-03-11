pragma solidity ^0.4.0;

import "./helper_contracts/strings.sol";

contract HelloWorld {

    using strings for *;

    address creator; // data-type 'address'
    string message; // data-type 'string'

    // constructor - runs once on contract creation transaction
    function HelloWorld() public {
        creator = msg.sender; // set 'creator' variable to address of transaction sender
        message = "Hello "; // set our message
    }

    function greet(string name) public constant returns (string) {
      return string(message.toSlice().concat(name.toSlice()));
    }
}
