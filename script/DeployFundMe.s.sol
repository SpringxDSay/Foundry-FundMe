// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
<<<<<<< HEAD
    function run() external returns (FundMe) {
        // Transaction before startBroadcast will not cost gas
        HelperConfig helperConfig = new HelperConfig();
        address ethPriceAddress = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethPriceAddress);
        vm.stopBroadcast();
        return fundMe;
    }
}
=======
    function run() external returns (FundMe){
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
