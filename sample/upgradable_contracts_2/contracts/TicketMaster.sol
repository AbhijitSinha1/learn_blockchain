pragma solidity ^0.4.20;

import "./Upgradable.sol";

contract TicketMaster is TicketMasterInterface {
  function cleanup(address newContractAddress) internal onlyOwner {
    // nothing to do in this example contract
  }
}
