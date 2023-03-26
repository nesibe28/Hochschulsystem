# Hochschulsystem

This project demonstrates a basic University System. 
It comes with two contracts, a Tokencontract for paying Semesterfees and a Studentmngmt.sol for all the functions available in this system and all the needed Vue-Components to display the UI for all the functionalities.

If any problems occur when deploying the contract , check if you have enough ether on your account to deploy.
If the system is running, and you have problems with seeing up-to-date data, then just refresh the webpage.
If a transaction gets dismissed, check for the error-message and see if you have enough ether to pay the Gas and if you are logged with the correct User.

Try running some of the following tasks:

```shell
npx hardhat clean
npx hardhat compile
npx hardhat run ./solidity/scripts/deploy.js --network goerli
npx hardhat node

npx hardhat help
```

## Adding a Vue.js web client

Once we have the contracts, run `vue create .` to bootstrap a vue.js project in the same folder.
