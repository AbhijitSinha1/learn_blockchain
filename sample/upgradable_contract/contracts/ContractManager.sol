pragma solidity ^0.4.18;

import "./DataStore.sol";
import "./Example.sol";

contract ContractManager {

  DataStore private contractStore;

  function ContractManager() public {
    contractStore = new DataStore();
    contractStore.setAddressValue("currentContractAddress", address(new Example()));
  }

  function getCurrentAddress() public view returns (address) {
    return contractStore.getAddressValue("currentContractAddress");
  }

  function upgrade() public {
    address currentContractAddress = contractStore.getAddressValue("currentContractAddress");
    address upgradedContractAddress = address(new Example());

    Example(currentContractAddress).upgrade(upgradedContractAddress);
    contractStore.setAddressValue("currentContractAddress", upgradedContractAddress);
  }
}
