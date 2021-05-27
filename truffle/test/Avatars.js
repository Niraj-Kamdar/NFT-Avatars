const Avatars = artifacts.require("Avatars");

contract("Avatars test", async accounts => {
    const ZERO_ADDRESS = "0x0000000000000000000000000000000000000000"
    let owner = accounts[0];
    let nonOwner = accounts[1];
    let catchRevert = require("./exceptions.js").catchRevert;
    let instance;

    describe("sanity check:", function() {
        before(async function() {
            instance = await Avatars.new(1000, 100);
        });
        it("should put 10**12 Transformium in the first account", async () => {
            const balance = await instance.balanceOf.call(accounts[0], 0);
            assert.equal(balance.valueOf(), 1000000000000);
        });
        it("should have avatarCreationFee of 1000", async () => {
            const fee = await instance.avatarCreationFee.call();
            assert.equal(fee.valueOf(), 1000);
        });
        it("should have attachmentCreationFee of 100", async () => {
            const fee = await instance.attachmentCreationFee.call();
            assert.equal(fee.valueOf(), 100);
        });
        it("should have 205 total tokens", async () => {
            const tokens = await instance.totalTokens.call();
            assert.equal(tokens.valueOf(), 205);
        });
    });

    describe("only owner can change avatarCreationFee:", function() {
        before(async function() {
            instance = await Avatars.new(1000, 100);
        });
        it("should complete successfully", async function() {
            await instance.setAvatarCreationFee(2000);
            const fee = await instance.avatarCreationFee.call();
            assert.equal(fee.valueOf(), 2000);
        });
        it("should abort with an error", async function() {
            await catchRevert(
                instance.setAvatarCreationFee(2000, {from: nonOwner}),
                "Ownable: caller is not the owner"
            );
        });
    });

    describe("only owner can change attachmentCreationFee:", function() {
        before(async function() {
            instance = await Avatars.new(1000, 100);
        });
        it("should complete successfully", async function() {
            await instance.setAttachmentCreationFee(200);
            const fee = await instance.attachmentCreationFee.call();
            assert.equal(fee.valueOf(), 200);
        });
        it("should abort with an error", async function() {
            await catchRevert(
                instance.setAttachmentCreationFee(200, {from: nonOwner}),
                "Ownable: caller is not the owner"
            );
        });
    });

    describe("only allow person with enough transformium to create an avatar", function() {
        before(async function() {
            instance = await Avatars.new(1000, 100);
        });
        it("should complete successfully", async function() {
            nextTokenId = await instance.totalTokens.call();
            tx = await instance.createAvatar();
            const eventLogs = tx.receipt.logs;
            // Check if it burns 1000 Transformium
            assert.equal(eventLogs[0].event, "TransferSingle");
            assert.equal(eventLogs[0].args.id.valueOf(), 0);
            assert.equal(eventLogs[0].args.value.valueOf(), 1000);
            assert.equal(eventLogs[0].args.from, owner); 
            assert.equal(eventLogs[0].args.to, ZERO_ADDRESS); 

            // Check if it mints a new Avatar NFT
            assert.equal(eventLogs[1].event, "TransferSingle");
            assert.equal(eventLogs[1].args.id.toString(), nextTokenId.toString());
            assert.equal(eventLogs[1].args.value.valueOf(), 1);
            assert.equal(eventLogs[1].args.from, ZERO_ADDRESS); 
            assert.equal(eventLogs[1].args.to, owner); 
        });
        it("should abort with an error", async function() {
            await catchRevert(
                instance.createAvatar({from: nonOwner}),
                "ERC1155: burn amount exceeds balance"
            );
        });
    });

    //   it("should call a function that depends on a linked library", async () => {
    //     const meta = await MetaCoin.deployed();
    //     const outCoinBalance = await meta.getBalance.call(accounts[0]);
    //     const metaCoinBalance = outCoinBalance.toNumber();
    //     const outCoinBalanceEth = await meta.getBalanceInEth.call(accounts[0]);
    //     const metaCoinEthBalance = outCoinBalanceEth.toNumber();
    //     assert.equal(metaCoinEthBalance, 2 * metaCoinBalance);
    //   });

    //   it("should send coin correctly", async () => {
    //     // Get initial balances of first and second account.
    //     const account_one = accounts[0];
    //     const account_two = accounts[1];

    //     const amount = 10;

    //     const instance = await MetaCoin.deployed();
    //     const meta = instance;

    //     const balance = await meta.getBalance.call(account_one);
    //     const account_one_starting_balance = balance.toNumber();

    //     balance = await meta.getBalance.call(account_two);
    //     const account_two_starting_balance = balance.toNumber();
    //     await meta.sendCoin(account_two, amount, { from: account_one });

    //     balance = await meta.getBalance.call(account_one);
    //     const account_one_ending_balance = balance.toNumber();

    //     balance = await meta.getBalance.call(account_two);
    //     const account_two_ending_balance = balance.toNumber();

    //     assert.equal(
    //       account_one_ending_balance,
    //       account_one_starting_balance - amount,
    //       "Amount wasn't correctly taken from the sender"
    //     );
    //     assert.equal(
    //       account_two_ending_balance,
    //       account_two_starting_balance + amount,
    //       "Amount wasn't correctly sent to the receiver"
    //     );
    //   });
});