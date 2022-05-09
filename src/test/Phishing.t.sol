// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../Phishing.sol";

contract PhishingTest is DSTest {
    Wallet wallet;
    Attack attack;

    Vm private vm = Vm(HEVM_ADDRESS);

    address alice;
    address eve = address(200);

    function setUp() public {
        wallet = new Wallet{value: 10 ether}();
        alice = wallet.owner();

        vm.prank(eve);
        attack = new Attack(wallet);
    }

    function testAttack() public {
        // Log initial balance of Alice's Wallet contract
        emit log_named_uint(
            "Initial Balance of Wallet Contract",
            address(wallet).balance
        );

        // Balance should be 10 ether
        assertEq(address(wallet).balance, 10 ether);

        // Set next call msg.sender & tx.orgin to alice's address
        vm.prank(alice, alice);

        // This is the point when Eve trick Alice to call a malicous contract
        attack.attack();

        // Log Wallet balance after attack
        emit log_named_uint(
            "Balance of Wallet Contract after attack",
            address(wallet).balance
        );

        // Next call will be by Eve
        vm.prank(eve);

        // Withdraw stolen funds
        attack.withdraw();

        // Log the balance of Eve's addrss
        emit log_named_uint("Eve's balance", eve.balance);
    }
}
