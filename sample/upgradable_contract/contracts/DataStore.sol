pragma solidity ^0.4.18;

contract DataStore {

  mapping(bytes32 => uint   ) private intStore;
  mapping(bytes32 => string ) private stringStore;
  mapping(bytes32 => address) private addressStore;

  // ---------------------
  // store
  // ---------------------

  function setIntValue(bytes32 variable, uint value) public {
    intStore[variable] = value;
  }

  function getIntValue(bytes32 variable) public view returns (uint) {
    return intStore[variable];
  }

  function setStringValue(bytes32 variable, string value) public {
    stringStore[variable] = value;
  }

  function getStringValue(bytes32 variable) public view returns (string) {
    return stringStore[variable];
  }

  function setAddressValue(bytes32 variable, address value) public {
    addressStore[variable] = value;
  }

  function getAddressValue(bytes32 variable) public view returns (address) {
    return addressStore[variable];
  }
}
