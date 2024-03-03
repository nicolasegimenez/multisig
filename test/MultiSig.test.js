const { expect } = require("chai");
const { ethers } = require("ethers");

describe("MultiSig", function () {
  let multiSig;
  let owner1;
  let owner2;
  let owner3;

  beforeEach(async function () {
    // Deploy the contract before each test case
    const MultiSig = await ethers.getContractFactory("MultiSig");
    const owners = [await signers[0].getAddress(), await signers[1].getAddress(), await signers[2].getAddress()];
    const required = 2;
    multiSig = await MultiSig.deploy(owners, required);
    await multiSig.deployed();

    owner1 = signers[0];
    owner2 = signers[1];
    owner3 = signers[2];
  });

  describe("Deployment", function () {
    it("should have the correct owners", async function () {
      const deployedOwners = await multiSig.owners();
      expect(deployedOwners).to.deep.equal(owners);
    });

    it("should have the correct required number of signatures", async function () {
      const deployedRequired = await multiSig.required();
      expect(deployedRequired).to.equal(required);
    });

    it("should have a starting nonce of 0", async function () {
      const deployedNonce = await multiSig.nonce();
      expect(deployedNonce).to.equal(0);
    });
  });

  // ... Add additional test cases for other functions

});
