var Migrations = artifacts.require("./DataStore.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
