pragma solidity ^0.4.20;

import "./helper_contracts/zeppelin/ownership/Ownable.sol";

contract Upgradable is Ownable {

  /*
  * use this method to perform all forms of house cleanig actions before upgrading the contract.
  */
  function cleanup(address newContractAddress) internal onlyOwner {}

  function upgrade(address newContractAddress) public onlyOwner {
    cleanup(newContractAddress);
    selfdestruct(newContractAddress);
  }
}
