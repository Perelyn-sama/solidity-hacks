// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import ".././src/HoneyPot.sol";

contract HoneyPotTest is DSTest {
    HoneyPot honeyPot;
    Bank bank;
    Attack attack;

    Vm private vm = Vm(HEVM_ADDRESS);

    address alice = address(this);
    address eve = address(200);

    function setUp() public {
        honeyPot = new HoneyPot();
        bank = new Bank(honeyPot);

        vm.prank(eve);
        attack = new Attack(bank);

        vm.deal(eve, 100);
    }

    // is meant to fail
    function testFailAttack() public {
        // Alice deposits 1 ether to bank
        bank.deposit{value: 1 ether}();

        // set next call to Eve
        vm.prank(eve);

        // Tries to attack contract and fails
        attack.attack();
    }
}
