// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.29;

import {Script, console2} from "forge-std/Script.sol";
import "../TestContract.sol";

contract TestContractScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Contract testContract = new Contract();
        vm.stopBroadcast();
    }
}
