<<<<<<< HEAD
// We need to be able to make less frequent calls to the alchemy API and we should be able to pull the priceFeed on other chains too(Not just sepolia Eth)
// Deploy mocks on anvil chain
// Keep track of contact addresses across different chains

// SPDX-License-Identifier: MIT
=======
//SPDX-License-Identifier: MIT
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

<<<<<<< HEAD
contract HelperConfig is Script {
    // If we are on anvil, deploy mocks, otherwise, grab existing ddress from the live network
    NetworkConfig public activeNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH/USD priceFeed
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getMainnetEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
=======

contract HelperConfig is Script {
    // If we are on a local anvil, deploy mocks
    // Else, grab existig CA from live network

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    constructor(){
    if(block.chainid == 11155111) {
        activeNetworkConfig = getSepoliaEthConfig();
    } else if (block.chainid == 1){
        activeNetworkConfig = getMainnetEthConfig();
    } 
    else {
        activeNetworkConfig = getOrCreateAnvilEthConfig();
    }
}

    NetworkConfig public activeNetworkConfig;
    struct NetworkConfig {
        address priceFeed; //ETH/USD price feed
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory){
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }

<<<<<<< HEAD
    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory mainnetEthConfig = NetworkConfig({priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return mainnetEthConfig;
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.priceFeed != address(0)) return activeNetworkConfig;
        // 1. Deploy the mock
        // 2. Return he mock address

=======
    
    function getMainnetEthConfig() public pure returns (NetworkConfig memory){
        NetworkConfig memory mainnetConfig = NetworkConfig({priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return mainnetConfig;
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory){
        if(activeNetworkConfig.priceFeed != address(0)) return activeNetworkConfig;

        // 1. Deploy the mocks
        // 2. Return the mock address
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

<<<<<<< HEAD
        NetworkConfig memory anvilEthConfig = NetworkConfig({priceFeed: address(mockPriceFeed)});
        return anvilEthConfig;
    }
}
=======
        NetworkConfig memory anvilConfig = NetworkConfig({priceFeed: address(mockPriceFeed)});
        return anvilConfig;

    }
}

// 1. Deploy mocks when we are on a local anvil chain
// 2. Keep track of CA across diferent chains
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
