// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotEnoughEthSent();
error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;
    address[] private s_funders;
    mapping(address => uint256) private s_funderAddressToAmount;
    address private immutable i_owner;
    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    function fund() public payable {
        if (msg.value.getConversionToUsd(s_priceFeed) < MINIMUM_USD) revert NotEnoughEthSent();
        s_funders.push(msg.sender);
        s_funderAddressToAmount[msg.sender] = msg.value;
    }

    function cheaperWithdraw() public onlyOwner {
        uint256 fundersLength = s_funders.length;
        for (uint256 i = 0; i < fundersLength; i++) {
            address funder = s_funders[i];
            s_funderAddressToAmount[funder] = 0;
        }
        s_funders = new address[](0);
        (bool success,) = i_owner.call{value: address(this).balance}("");
        require(success);
    }

    function withdraw() public onlyOwner {
        for (uint256 fundersIndex = 0; fundersIndex < s_funders.length; fundersIndex++) {
            address funder = s_funders[fundersIndex];
            s_funderAddressToAmount[funder] = 0;
        }

        s_funders = new address[](0);
        (bool success,) = i_owner.call{value: address(this).balance}("");
        require(success);
    }

    /**
     * View/Pure Functions (Getters)
     */
    function getAddressToAmountFunded(address fundingAddress) external view returns (uint256) {
        return s_funderAddressToAmount[fundingAddress];
    }

    function getFunder(uint256 funderIndex) external view returns (address) {
        return s_funders[funderIndex];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
}
