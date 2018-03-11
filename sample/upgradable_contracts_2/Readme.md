#Upgradable Contracts

In this project we will build contracts whose functionalities can be upgraded. The biggest issue with upgrading contracts is the loss of data. To achive upgradability we need to structure our contracts in a specific way.

The contract needs to be upgraded for any of the following reasons:
* The functionality needs to be changed
* New functionality needs to be added
* Old functionality needs to be removed

In this example project we would build and deploy a sample contract with certain functionalities and then upgrade the contract to change some old functionality, add more functionality and remove some old functionality.

While doing so we need to make sure that the data that we save in the blockchain remians intact.
The usecase that we would tackle is of ticket distribution. We will deploy a contract which lets users book tickets by paying appropriate amount.

The upgrade to this would allow the users to get a refund of the tickets if they change their mind.

While making the upgrade we would need to ensure that the data for the previous users is not lost.

##References
1. [blog.colony.io]( https://blog.colony.io/writing-upgradeable-contracts-in-solidity-6743f0eecc88) - Elena Dimitrova
2. [blog.imaginea.com](https://blog.imaginea.com/interfaces-make-your-solidity-contracts-upgradeable/) - Chandan Kumar
