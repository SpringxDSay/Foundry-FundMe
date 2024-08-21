// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getEthPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        (, int256 ethPrice,,,) = priceFeed.latestRoundData();
        return uint256(ethPrice * 1e10);
    }

    function getConversionToUsd(uint256 _ethAmount, AggregatorV3Interface priceFeed) internal view returns (uint256) {
        uint256 ethPrice = getEthPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * _ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
