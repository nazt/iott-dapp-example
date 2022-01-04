const { ethers } = require('hardhat');
const { verifyContract } = require('./utils');

const name = 'Device';

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const Oracle = await ethers.getContract('Oracle');

  const args = [Oracle.address, 0];

  const tx = await deploy(name, {
    contract: name,
    from: deployer,
    args,
    log: true,
  });

  await verifyContract(tx.address, args);
};

module.exports.tags = [name];
