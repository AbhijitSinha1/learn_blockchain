pragma solidity ^0.4.18;

import "./DataStore.sol";

contract Example {

  DataStore private store;
  address private storeAddress;

  function Example() public {
    store = new DataStore();
    storeAddress = address(store);
  }

  function setStore(address _storeAddress) public {
    store = DataStore(_storeAddress);
    storeAddress = _storeAddress;
  }

  function setValue(uint value) public {
    store.setIntValue("value", value);
  }

  function getValue() public view returns (uint) {
    return store.getIntValue("value");
  }

  function sendMoney() public payable {
    uint price = msg.value;
    price = store.getIntValue("money") + price;
    store.setIntValue("money", price);
  }

  function getAmount() public view returns (uint) {
    return store.getIntValue("money");
  }

  function getBalance() public view returns (uint) {
    return this.balance;
  }

  function getStoreAddress() public view returns (address) {
    return storeAddress;
  }

  function upgrade(address newAddress) public {
    Example(newAddress).setStore(storeAddress);
    selfdestruct(newAddress);
  }

}
