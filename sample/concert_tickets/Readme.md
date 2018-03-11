# ConcertTicket

In this project, we create a contract that allows users to purchase concert tickets. The contract is initialized with a total of 5 tickets each priced at 1 ether. Users can make use of the following public functions:
1. `bookTicket(uint count)`: to book `count` number of tickets by sending proper funds
2. `refund(uint count)`: to get back funds and return `count` number of the tickets

The owner can use the following functions:
1. `count()`: to count how many tickets remain unbooked
2. `done()`: once all the tickets have been booked or the booking period is over, this will `selfdestruct` the contract and transfer the funds to the contract owner.
