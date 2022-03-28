const TimeLock = artifacts.require("TimeLock");
const Attack = artifacts.require("Attack");

module.exports = async function (deployer) {
  deployer.deploy(TimeLock);

  let timeLock = await TimeLock.deployed();

  deployer.deploy(Attack, timeLock.address);
};
