# Upgradable Contract

In this project I have worked on the upgradability of contracts. The contract that we would be upgrading is `Example.sol`. The structure of `Example.sol` is quite staright forward, since this contract is used to store just two pieces of information:
* a user defined value
* amount of money (funds) transfered to the contract.

The very simplest implementation of `Example.sol` was:

```
pragma solidity ^0.4.18;

contract Example {

  uint value;
  uint money;

  function setValue(uint _value) public {
    value = _value;
  }

  function getValue() public view returns (uint) {
    return value;
  }

  function sendMoney() public payable {
    money = money + msg.value;
  }

  function getAmount() public view returns (uint) {
    return money;
  }

  function getBalance() public view returns (uint) {
    return this.balance;
  }
}
```

This of course is not upgradable, since, when we redeploy the contract all the information is lost. This is because the data is stored in variables which are tightly linked to the contract being upgraded. When the contract is  upgraded, its address changes and the values stored in the old contract is no longer available in this upgraded contract. In order to make sure that the data is not lost while the contract is upgraded, we need to decouple the data and the contract logic. The external data storage should stay same even when the contract containing the business logic gets upgarded.

Once we decide to store the data outside, we need to make sure that the data store is able to
* store any kind of data that we might want to add in the future.
* the data store should not be in any way dependent on the current contract

I therefore came up with this simple yet generic [datastore](contracts/DataStore.sol). It stores data of types:
* uint
* string
* address

While storing the data, the user provides the value and the name of the variable like: `setIntValue("example", 42)`. And while extracting the data back the user can use the variable name like: `getIntValue("example")` which gives `42`. Since this datastore is so generic, we should never need to upgrade this contract, in which case we could use the address of this contract in all our other contracts to store information.

Let us now update the `Example.sol` to incorporate the `DataStore.sol`.
```
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
  }
}
```

You can see that now the data is not stored in the local variable, but in the datastore. And whenever we need to upgrade the contract, we simply pass on the store address from the previous contract to the new contract. I have provided a convenience method `upgrade(address)` which upgrades the old contract with the new version by passing on the datastore address.

There are however two major issues with this contract, which make it unusable in its current form.

* While upgrading the contract funds are not transfered to the new contract.
* The upgrade process still requires the client to know the address of the old and the new contracts and all the old contracts are still active.

To explain the two issues in detail:
* Say you sent `10 ether` to the old contract, and then you upgraded the contract. Now if you call the `getAmount()` in the upgraded contract you would still get that the contract has `10 ether`, however if you call `getBalance()` the result would be `0 ether`.
* The second issue is that the client interacts with the contract by directly using its address. Once the contract is upgradeed, the old contracts are not destroyed so if some external contract is still using the old contract address, it will be making use of incorrect functionality, which defeats the purpose of upgradability. Which in turn means that all contracts which are making use of `Example.sol` need to be aware of the upgrades made to the contract.

The first issue is quite easy to solve. Solidity has a `selfdestruct()` which kills the contract calling the method. This method also takes an address and transfers all its funds to that address. We update the `upgarde()` in `Example.sol` as follows:

```
function upgrade(address newAddress) public {
  Example(newAddress).setStore(storeAddress);
  selfdestruct(newAddress);
}
```

The second issue is a bit tricky one to tackle. To overcome this issue, we create another contract called `ContractManager.sol` which like `DataStore.sol` is expected to never be upgarded and, as the name suggests, will be used to keep track of the contracts. The structure of the contract is as follows:

```
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
```

This way, all the external contracts which need to use `Example.sol` can simply use the `getCurrentAddress()` of `ContractManager.sol` to get the currently active version. The manager also has a `upgrade()` which makes sure that the contracts can be upgraded in a clean fashion.

This way we have craeted a simple yet upgradable contract. We are now only left with issues of ensuring the correct authority while calling various methods, specifically, currently there is no check on any of the methods and anyone can call the `upgrade()`. We should always check that the the contracts are upgraded only by the owner of the contract. But we will not get into that in this project.
