// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

import "ds-test/test.sol";
import ".././src/Reentrancy.sol";
import ".././src/ArithmeticFlow.sol";
import "forge-std/Test.sol";

contract ArithmeticFlowTest is DSTest {
    TimeLock timeLock;
    Attack attack;
    Vm private vm = Vm(HEVM_ADDRESS);

    address addr1 = address(100);
    address addr2 = address(200);

    function setUp() public {
        timeLock = new TimeLock();
        attack = new Attack(timeLock);

        vm.deal(addr1, 100);
        vm.deal(addr2, 100);
    }

    // Could not work because of conflict with foundry libraries solidity versions and test version
    function testAttack() public {
        vm.prank(addr1);
        timeLock.deposit{value: 20 ether}();

        emit log_named_uint("addr1 balance", addr1.balance);

        vm.prank(addr2);
        attack.attack{value: 2 ether}();

        emit log_named_uint("addr2 balance", addr2.balance);
    }
}
