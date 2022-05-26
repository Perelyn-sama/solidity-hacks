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

    fallback() external payable {}

    receive() external payable {}

    function setUp() public {
        // vm.prank(addr1);
        // crossFunction = new CrossFunction{value: 1 ether}();
        crossFunction = new CrossFunction();

        vm.deal(addr1, 100);
        vm.deal(addr2, 100);
        vm.deal(addr3, 100);
    }

    function testAttack() public {
        crossFunction.deposit{value: 1 ether}();
        emit log_named_uint(
            "Ether in contract",
            crossFunction.getBalance() / 1e18
        );

        crossFunction.transfer(addr3, 1 ether);
        crossFunction.balanceOf(addr3);

        vm.prank(addr3);
        crossFunction.withdrawalBalance();
        emit log_named_uint("balance of addr3", addr3.balance / 1e18);

        crossFunction.withdrawalBalance();
        emit log_named_uint(
            "Ether in contract",
            crossFunction.getBalance() / 1e18
        );
    }
}
