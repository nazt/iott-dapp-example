// import { Signer } from "ethers"
// import { DeployFunction } from "hardhat-deploy/types"
// import { HardhatRuntimeEnvironment } from "hardhat/types"

const { ethers } = require("hardhat")
const { verifyContract } = require("./utils")

const name = "Oracle"

console.log(".......")
module.exports = async ({ getNamedAccounts, deployments: any }) => {
  const { deploy } = deployments
  const { deployer } = await getNamedAccounts()

  console.log(".......")

  const args = []

  const tx = await deploy(name, {
    contract: name,
    from: deployer,
    args,
    log: true,
  })

  // await verifyContract(tx.address, args);
}

module.exports.tags = [name]

// const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
//   let accounts: Signer[];

//   console.log('hello world!')
// }

// export default func;
// // func.id = "nft_token_deploy";
// func.tags = ["Oracle"];
