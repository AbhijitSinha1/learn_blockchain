# Readme

Use the setup files to start your own private blockchain network.

Usage:
1. `./setup.sh -w [workspace] -d [directory where the blockchain files are stored]`
2. `./setup2.sh`

or you can start a blockchain network by calling `testrpc`

Once the blockchain network has started, create a truffle project.
1. `cd path/to/project`
2. `truffle init`
3. put your contracts in `contracts/`

To test your contract:
1. `truffle compile`
2. in `migrate/` create a `.js` file for example: `2_concert_ticket.js`
```
var ConcertTicket = artifacts.require("./ConcertTicket.sol");
module.exports = function(deployer) {
  deployer.deploy(ConcertTicket);
};
```
3.  in the project root folder edit the `truffle.js` file
```
module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*'   // Match any network id
    }
  }
};
```
4. migrate the contracts: `truffle migrate`
5. start truffle console: `truffle console`
6. you can now test your contract in the console

**Note**: if you update your contract, you would have to redo steps 4, 5, 6, with a minor modification in step 4: `truffle migrate --reset`.

**Also Note**: If you make changes to the contract and redeploy you are not actually updating your contract. You are creating a new contract with a new address location on the blockchain. Upgrading an old contract is a non trivial issue, and you should look into it. 
