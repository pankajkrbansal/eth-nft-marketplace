require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
require("dotenv").config({ path: ".env" });

const key = process.env.PRIVATE_KEY;
const url = process.env.ALCHEMY_NODE_URL;

module.exports = {
  solidity: {
    compilers: [
      { version: "0.8.0" },
      { version: "0.8.1" },
      { version: "0.8.2" },
      { version: "0.8.3" },
    ],
  },
  networks: {
    goerli: {
      url: url,
      acounts: [key],
    },
  },
};
