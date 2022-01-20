import "@nomiclabs/hardhat-waffle";
require('@nomiclabs/hardhat-waffle');
require('@nomiclabs/hardhat-ethers');
require('@nomiclabs/hardhat-etherscan'); // contract verification service.
require('hardhat-spdx-license-identifier');
require('hardhat-gas-reporter');
require('hardhat-deploy');
require('hardhat-deploy-ethers');
require('solidity-coverage');
// require('./hardhat')
import "@typechain/hardhat";

import 'hardhat-deploy'

import dotenv from 'dotenv';

dotenv.config({ path: '.env' });

const { PRIVATE_KEY } = process.env;

export default {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
    },
    bscTest: {
      url: 'https://data-seed-prebsc-1-s1.binance.org:8545',
      saveDeployments: true,
      tags: ['bscTest'],
      accounts: [PRIVATE_KEY],
    },
    testnet: {
      url: 'https://babel-api.testnet.iotex.io',
      accounts: [PRIVATE_KEY],
      chainId: 4690,
      gas: 8500000,
      gasPrice: 1000000000000
    },
    mainnet: {
      url: 'https://babel-api.mainnet.iotex.io',
      accounts: [PRIVATE_KEY],
      timeout: 3 * 20000,
      chainId: 4689,
      gas: 8500000,
      gasPrice: 1000000000000
    },
    kovan: {
      url: 'https://kovan.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
      saveDeployments: true,
      tags: ['kovan'],
      accounts: [PRIVATE_KEY],
    },
    rinkeby: {
      url: 'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
      saveDeployments: true,
      tags: ['rinkeby'],
      accounts: [PRIVATE_KEY],
    },
  },
  gasReporter: {
    enabled: false,
    showTimeSpent: true,
  },
  spdxLicenseIdentifier: {
    overwrite: true,
    runOnCompile: true,
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  },
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion: "petersburg"
    }
  },
  namedAccounts: {
    deployer: 0,
  },
  typechain: {
    outDir: "typechain",
    target: "ethers-v5",
  },
};


// https://github.com/wighawag/tutorial-hardhat-deploy
// https://github.com/protokol/solidity-typescript-hardhat-template
// yarn hardhat --network rinkeby etherscan-verify --api-key <api-key>