// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "ds-test/test.sol";
import "../Reentrancy.sol";
import "../ExternalContract.sol";
import "forge-std/Test.sol";

contract ExternalContractTest is DSTest {
    Foo foo;
    Bar bar;
    Mal mal;
    Vm private vm = Vm(HEVM_ADDRESS);

    address addr1 = address(100);
    address addr2 = address(200);

    function setUp() public {
        mal = new Mal();
        foo = new Foo(address(mal));
    }

    function testAttack() public {
        vm.prank(addr1);
        foo.callBar();
    }
}
