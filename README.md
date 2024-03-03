# Multisignature Wallet with Hardhat and Ethers.js

**Introduction**

This project implements a secure multisignature wallet smart contract in Solidity and connects it to a basic user interface using Hardhat and Ethers.js. This allows multiple owners to jointly manage funds and transactions, requiring a minimum number of approvals for each transaction to be executed.

**Prerequisites**

* Node.js and npm (or yarn) installed
* Basic understanding of Solidity, Ethereum blockchain, and smart contract development
* Familiarity with Hardhat and Ethers.js

**Setup**

1. Clone this repository.
2. Install dependencies:

   ```bash
   npm install
   ```

3. Create a `.env` file in the project root directory and add:

   ```
   RINKEBY_URL=YOUR_RINKEBY_NODE_URL // Replace with your Rinkeby node URL
   PRIVATE_KEY=YOUR_PRIVATE_KEY // Replace with your private key for deploying the contract
   ```

**Deployment**

1. Compile the contract:

   ```bash
   npx hardhat compile
   ```

2. Deploy the contract to the Rinkeby testnet:

   ```bash
   npx hardhat run scripts/deploy.js
   ```

   This script will deploy the contract and print the contract address. Store this address for later use.

**Frontend and Interaction**

1. Open `index.html` in your browser.
2. Connect your Metamask wallet to the Rinkeby testnet.
3. Enter the contract address deployed in the previous step.
4. Interact with the wallet using the provided buttons and prompts.

**Functionality**

* **Add Owners:** Add new owners to the wallet (requires contract owner privileges).
* **Submit Transaction:** Propose a transaction with recipient, amount, and nonce.
* **Approve Transaction:** Approve a pending transaction using your Metamask wallet.
* **Execute Transaction:** Execute a transaction if enough approvals are met (requires minimum required signatures).
* **View Transactions:** List pending and executed transactions with details.

**Note:**

* This is a basic example for learning purposes. Thorough testing and security considerations are essential before deploying such a system in a real-world environment.

**Additional Resources**

* Hardhat documentation: [https://hardhat.org/hardhat-runner/docs/config](https://hardhat.org/hardhat-runner/docs/config)
* Ethers.js documentation: [https://ethers.io/](https://ethers.io/)
* Solidity documentation: [https://docs.soliditylang.org/](https://docs.soliditylang.org/)

**Contributing**

Feel free to fork this repository and make improvements! Pull requests are welcome.
