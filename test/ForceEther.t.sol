// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import ".././src/ForceEther.sol";

contract ForceEtherTest is DSTest {
    EtherGame etherGame;
    Attack attack;
    Vm private vm = Vm(HEVM_ADDRESS);

    address addr1 = address(100);
    address addr2 = address(200);

    function setUp() public {
        etherGame = new EtherGame();
        attack = new Attack(etherGame);

        vm.deal(addr1, 100);
        vm.deal(addr2, 100);
    }

    function testAttack() public {
        // vm.prank(addr1);
        // etherGame.deposit{value: 1 ether}();

        // vm.prank(addr2);
        etherGame.deposit{value: 1 ether}();

        uint256 bal = address(etherGame).balance;

        emit log_named_uint("Balance of Ether game", bal);

        attack.attack{value: 5 ether}();

        emit log_named_uint("Balance of Ether game", bal);
    }
}
