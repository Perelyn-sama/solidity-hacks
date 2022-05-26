// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "ds-test/test.sol";
import ".././src/CrossFunction.sol";
import "forge-std/Test.sol";

contract CrossTest is DSTest {
    CrossFunction crossFunction;
    Vm private vm = Vm(HEVM_ADDRESS);

    address addr1 = address(100);
    address addr2 = address(200);
    address addr3 = address(300);

    function setUp() public {
        // vm.prank(addr1);
        crossFunction = new CrossFunction();

        vm.deal(addr1, 100);
        vm.deal(addr2, 100);
    }

    function testAttack() public {
        emit log_uint(msg.sender.balance);
        crossFunction.deposit{value: 10 ether}();
        emit log_uint(msg.sender.balance);
    }
}

// 79228162514264337593543950335
//   79228162514264337593543950335
