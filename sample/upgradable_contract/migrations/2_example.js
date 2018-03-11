var Migrations = artifacts.require("./Example.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
