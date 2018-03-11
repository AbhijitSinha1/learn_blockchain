# Blockchain Introduction

## Contents
* [What is blockchain in layman terms?](#intro)
* [What are the different usecases of blockchain?](#usecase)
* [How does one start developing for blockchain?](#setup)
* [References](#references)

**Disclaimer: I have just started learing about blockchain and therefore this repository is a work in progress. The aim of this repo is to document my knowledge which might help others understand this upcoming technology**

## <a name="intro"></a> What is blockchain in layman terms?
Blockchain, in its simplest form, is a distributed database. All participants of a blockchain network gets a copy of the database and when new data needs to be added, it is brodcasted to all the participants.

But lets try understand blockchain a bit further. As the name suggests, blockchain is a chain of blocks. Blocks hold change in data at any instant and a chain of blocks hold the complete history of data from the start.

What is this 'change in data'? Lets say we start with an empty database. In blockchain terms, the chain in currently empty. Now, lets say a user registers on our site and so their information needs to be added to the database. This new information is the 'change in data', which will be placed in a block and added to the blockchain. Now the blockchain has one block. If this user, at a later point, goes on to update some detail about themselves, this change will be added as another block in the blockchain. This way the blockchain grows.

At this point you should take a look at [this video](https://www.youtube.com/watch?v=_160oMzblY8) and its [second part](https://www.youtube.com/watch?v=xIDL_akeras).

To get a bit more technical understanding of blockchain and how it ensures security of data in a distributed database system, watch [this video](https://www.youtube.com/watch?v=Lx9zgZCMqXE)

## <a name="usecase"></a>What are the different usecases of blockchain?
The concept of blockchain was introduced in a paper, by a person/group under the pseudonym of Satoshi Nakamoto, in 2008 titled ['Bitcoin: A Peer-to-Peer Electronic Cash System'](https://bitcoin.org/bitcoin.pdf). This paper suggested the use of blockchain in a peer-to-peer cash transaction system.

Since then, many more use cases have come up for decentralized applications which utilize blockchain as their data storage facility.

An important thumbrule that one can make use of while deciding whether to go for a blockchain based decentralized application: Do you trust all parties involved in the application. If not, you can go for a blockchain based app.

For example in case of bitcoin, the purpose of the application is to tranfer money from one to another. This task has traditionally been done by banks. But what if you do not trust your bank to securely/honestly transfer the funds? You fear that your bank is a central source of information about how much money you have in your acount, and if this source is comprimised your money is gone.

Another usecase could be in music industry where artists and patrons are part of the system. Currently the music is distributed by single/few distributors. If the distributor is compromised someohow, the artist loses their share. If however the music is distributed over blockchain, all parties involved will be aware of the flow of content from the artist to individual patrons. Everyone can verify whether a trasfer of music file from one to another is valid and there is no need to place your trust on a single entity.

Distributed applications based on blockchain help spread the responsibility of a single entity to all the parties involved. This way even if an entity is compromised, others can take over. As long as a majority of the entities are honest, the system works flawlessly.

[Ethereum](https://www.ethereum.org/) has developed a platform to build decentralized application on blockchain.

## <a name="setup"></a>How does one start developing for blockchain?
Ethereum applications are written using the programming language called [solidity](https://solidity.readthedocs.io/en/develop/). The syntax is similar to typescript. There are various frameworks that can be used to develop ethereum apps, two of which are truffle and remix. Here we would learn how to setup and start coding using truffle.

But before we start coding, we need to get familiar with the ethereum paradigm. The way ethereum works is through smart contracts. Smart contracts are pieces of code which are deployed on the blockchain and are executed when certain conditions are met. Each smart contract has an address, to which one could send funds.

We would like to cover the following topics:
1. what are smart contracts and how do they work
2. what is a Genesis block
3. how to build frontend - backend - database application.
4. web3.js

## <a name="references"></a>References
* [Genesis block explained](https://ethereum.stackexchange.com/a/2377)
* [Config parameter in a block explained](https://ethereum.stackexchange.com/a/15687)
