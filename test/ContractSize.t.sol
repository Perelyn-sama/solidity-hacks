// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

// import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/ContractSize.sol";

contract ContractSizeTest is Test {
    Target target;
    FailedAttack failedAttack;
    Hack hack;

    address alice = address(this);
    address eve = address(200);

    function setUp() public {
      target = new Target();
      failedAttack = new FailedAttack();
    }

    // is meant to fail
    function testFailAttack() public {
        failedAttack.pwn(address(target));
    }

    function testHack() public {
      hack = new Hack(address(target));
    }
}
