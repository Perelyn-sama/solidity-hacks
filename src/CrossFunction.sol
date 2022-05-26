// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract CrossFunction {
    mapping(address => uint256) public userBalances;

    constructor() payable {}

    receive() external payable {}

    function deposit() public payable {
        userBalances[msg.sender] += msg.value;
    }

    /* uses userBalance to transfer funds */
    function transfer(address to, uint256 amount) public returns (bool) {
        if (userBalances[msg.sender] >= amount) {
            userBalances[to] += amount;
            userBalances[msg.sender] -= amount;
            return true;
        } else {
            return false;
        }
    }

    /* uses userBalances to withdraw funds */
    function withdrawalBalance() public {
        uint256 amountToWithdraw = userBalances[msg.sender];

        (bool sent, ) = msg.sender.call{value: amountToWithdraw}("");
        require(sent, "Failed to send Ether");
        userBalances[msg.sender] = 0;
    }

    function balanceOf(address addr) public view returns (uint256) {
        return userBalances[addr];
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
