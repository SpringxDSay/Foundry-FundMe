// SPDX-License-Identifier: MIT
// Fund
//Withdraw

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant VALUE_SENT = 0.1 ether;

    function fundFundMe(address mostRecentlyDeployedContract) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployedContract)).fund{value: VALUE_SENT}();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployedContract = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployedContract);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployedContract) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployedContract)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployedContract = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentlyDeployedContract);
    }
}
