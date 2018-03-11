var ConcertTicket = artifacts.require("./ConcertTicket.sol");

module.exports = function(deployer) {
  deployer.deploy(ConcertTicket);
};
