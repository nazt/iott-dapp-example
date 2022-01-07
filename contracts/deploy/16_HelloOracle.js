// import { Signer } from "ethers"
// import { DeployFunction } from "hardhat-deploy/types"
// import { HardhatRuntimeEnvironment } from "hardhat/types"

const { ethers } = require("hardhat")
const { verifyContract } = require("./utils")

const name = "HelloOracle"

//  npx hardhat run scripts/12_Oracle.js --network mainnet
//  hh run scripts/12_Oracle.js
//  hh run scripts/12_Oracle.js
//  hh run scripts/12_Oracle.js
//  npx hardhat run scripts/12_Oracle.js --network mainnet

module.exports = async ({ getNamedAccounts, deployments: any }) => {
  const { deploy } = deployments
  const { deployer } = await getNamedAccounts()

  console.log(".......", deploy, deployer)

  const args = [deployer]

  const tx = await deploy(name, {
    contract: name,
    from: deployer,
    args,
    log: true,
  })

  //   await verifyContract(tx.address, args)
}

module.exports.tags = [name]
