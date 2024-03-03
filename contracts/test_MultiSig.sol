// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MultiSig.sol";

contract TestMultiSig {
    MultiSig public multiSig;

    function beforeEach() public {
        multiSig = new MultiSig();
        multiSig.owners.push(address(0x1)); // Owner 1
        multiSig.owners.push(address(0x2)); // Owner 2
        multiSig.owners.push(address(0x3)); // Owner 3
        multiSig.required = 2; // Require 2 approvals
    }

    function testSubmitTransaction() public {
        uint initialNonce = multiSig.nonce();
        uint transactionId = initialNonce + 1;

        multiSig.submitTransaction(address(0x4), 100);

        Assert.equal(multiSig.transactions(transactionId).recipient, address(0x4), "Recipient should match");
        Assert.equal(multiSig.transactions(transactionId).amount, 100, "Amount should match");
        Assert.equal(multiSig.transactions(transactionId).nonce, transactionId, "Nonce should match");
        Assert.equal(multiSig.nonce(), initialNonce + 2, "Nonce should be incremented");
    }

    function testApproveTransaction() public {
        uint transactionId = multiSig.nonce() + 1;

        multiSig.submitTransaction(address(0x4), 100);
        multiSig.approveTransaction(transactionId);

        Assert.isTrue(multiSig.approved(transactionId, address(0x1)), "Owner 1 should have approved");
        Assert.isTrue(multiSig.approved(transactionId, address(0x2)), "Owner 2 should have approved");
        Assert.isFalse(multiSig.approved(transactionId, address(0x3)), "Owner 3 should not have approved");
    }

    function testExecuteTransaction() public {
        uint transactionId = multiSig.nonce() + 1;

        multiSig.submitTransaction(address(0x4), 100);
        multiSig.approveTransaction(transactionId);
        multiSig.executeTransaction(transactionId);

        Assert.isTrue(multiSig.isExecuted(transactionId), "Transaction should be marked as executed");
    }
}