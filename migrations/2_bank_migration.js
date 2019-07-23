const Piggybank = artifacts.require("Piggybank");

module.exports = function(deployer) {
  deployer.deploy(Piggybank);
};
