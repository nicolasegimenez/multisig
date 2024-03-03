//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

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

    function submitTransaction(address payable recipient, uint amount) public onlyOwners {
        nonce++; // Increment the nonce
        transactions[nonce] = Transaction(recipient, amount, nonce); // Store the transaction details
        nonce += 1;
    }

    /* Create a function approveTransaction for owners to approve a proposed transaction.
    Update the approved mapping for the transaction. */
    function approveTransaction(uint transactionId) public onlyOwners {
        require(!approved[transactionId][msg.sender], "Already approved");
        approved[transactionId][msg.sender] = true;
    }

    /* Create a function executeTransaction to execute a transaction if enough approvals are met.
    Transfer funds and update the approved mapping. */
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
    isExecuted[transactionId] = true;
}

}
    






