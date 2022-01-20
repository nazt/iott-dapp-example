// import { Signer } from "ethers"
// import { DeployFunction } from "hardhat-deploy/types"
// import { HardhatRuntimeEnvironment } from "hardhat/types"

const { ethers } = require("hardhat")
const { verifyContract } = require("./utils")

const name = "DeviceOracle"

module.exports = async ({ getNamedAccounts, deployments: any }) => {
  const { deploy } = deployments
  const { deployer } = await getNamedAccounts()

  console.log(".......", deploy, deployer)

  const args = []

  const tx = await deploy(name, {
    contract: name,
    from: deployer,
    args,
    log: true,
  })
}

module.exports.tags = [name]
