pragma solidity ^0.4.17;

contract ConcertTicket {
  address owner;
  uint ticketCount;
  uint price;
  mapping (address => uint) bookings;

  modifier onlyOwner() {
    if (msg.sender == owner) {
      _;
    }
  }

  function ConcertTicket() public {
    owner = msg.sender;
    price = 1;
    ticketCount = 5;
  }

  function bookTicket(uint count) public payable returns (bool) {
    if (count > ticketCount) {
      return false;
    }
    if (count * price != msg.value) {
      return false;
    }
    bookings[msg.sender] += count;
    ticketCount -= count;
    return true;
  }

  function refund(uint count) public payable returns (bool) {
    if (count == 0) {
      // nothing to do here
      return true;
    }
    if (bookings[msg.sender] == 0) {
      return false;
    }
    if (bookings[msg.sender] < count) {
      count = bookings[msg.sender];
    }
    ticketCount += count;
    bookings[msg.sender] -= count;
    uint value = price * count;
    msg.sender.transfer(value);
    return true;
  }

  function count() onlyOwner public constant returns (uint) {
    return ticketCount;
  }

  function done() onlyOwner public payable returns (bool) {
    selfdestruct(owner);
    return true;
  }

  function() public {
    revert();
  }

}
