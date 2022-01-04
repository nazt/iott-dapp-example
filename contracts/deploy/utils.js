const verifyContract = async (contractAddress, args) => {
  await run('verify:verify', {
    address: contractAddress,
    constructorArguments: args,
  });
};

module.exports = {
  verifyContract,
};
