// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../TestContract.sol";

contract TestContractTest is Test {
    Contract public testContract;

    address public creatorAddress = address(0x1234);

    function setUp() public {
        vm.createSelectFork(vm.envString("ETH_RPC_URL"));
        vm.deal(creatorAddress, 100 ether);

        testContract = new Contract();
        testContract.grantRole(testContract.RECORD_CREATOR_ROLE(), creatorAddress);
    }

    function testMessageSet() public {
        vm.prank(creatorAddress);
        testContract.addRecord(1, "hi");
        assertEq(testContract.getMessage(1), "hi");
    }
}
