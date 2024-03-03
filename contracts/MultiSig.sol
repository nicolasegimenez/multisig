// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * @title MultiSig
 * @dev A contract that implements a multi-signature wallet.
 */
contract MultiSig {
    address[] public owners;
    uint public required;
    uint public nonce; // Declare the nonce variable

    struct Transaction {
        address payable recipient;
        uint amount;
        uint nonce;
    }

    mapping(uint => Transaction) public transactions; // Declare the transactions mapping
    mapping(uint => mapping(address => bool)) public approved;
    mapping(uint => bool) public isExecuted; // Declare the isExecuted mapping

    /**
     * @dev Modifier to restrict access to only the owners of the multi-signature wallet.
     */
    modifier onlyOwners() {
        bool isOwner = false;
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) {
                isOwner = true;
                break;
            }
        }
        require(isOwner, "Only owners can call this function");
        _; // Code to be executed
    }

    /**
     * @dev Submit a new transaction to be approved and executed.
     * @param recipient The address of the recipient.
     * @param amount The amount to be transferred.
     */
    function submitTransaction(address payable recipient, uint amount) public onlyOwners {
        nonce++; // Increment the nonce
        transactions[nonce] = Transaction(recipient, amount, nonce); // Store the transaction details
        nonce += 1;
    }

    /**
     * @dev Approve a proposed transaction.
     * @param transactionId The ID of the transaction to be approved.
     */
    function approveTransaction(uint transactionId) public onlyOwners {
        require(!approved[transactionId][msg.sender], "Already approved");
        approved[transactionId][msg.sender] = true;
    }

    /**
     * @dev Execute a transaction if enough approvals are met.
     * @param transactionId The ID of the transaction to be executed.
     */
    function executeTransaction(uint transactionId) public onlyOwners {
        Transaction storage tx = transactions[transactionId];
        require(!isExecuted[transactionId], "Transaction already executed");
        uint approvalsCount = 0;
        for (uint i = 0; i < owners.length; i++) {
            if (approved[transactionId][owners[i]]) {
                approvalsCount++;
            }
        }
        require(approvalsCount >= required, "Not enough approvals");
        tx.recipient.transfer(tx.amount);
        isExecuted[transactionId] = true; // Mark the transaction as executed
    }
}
