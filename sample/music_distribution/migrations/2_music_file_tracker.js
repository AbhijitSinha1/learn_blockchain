var Migrations = artifacts.require("./MusicFileTracker.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
