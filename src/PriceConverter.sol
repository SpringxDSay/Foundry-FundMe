// SPDX-License-Identifier: MIT
<<<<<<< HEAD

=======
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

<<<<<<< HEAD
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
=======
// Why is this a library and not abstract?
// Why not an interface?
library PriceConverter {
    // We could make this public, but then we'd have to deploy it
    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 10000000000);
    }

    // 1000000000
    function getConversionRate(
        uint256 ethAmount, AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
