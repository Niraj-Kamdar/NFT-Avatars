let Avatars = artifacts.require("Avatars");

module.exports = function (deployer) {
    // deployment steps
    deployer.deploy(Avatars);
};