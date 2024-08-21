<<<<<<< HEAD
// SPDX-License-Identifier: MIT

=======

// SPDX-License-Identifier: MIT
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

<<<<<<< HEAD
error NotEnoughEthSent();
=======
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

<<<<<<< HEAD
    uint256 public constant MINIMUM_USD = 5 * 1e18;
    address[] private s_funders;
    mapping(address => uint256) private s_funderAddressToAmount;
    address private immutable i_owner;
    AggregatorV3Interface private s_priceFeed;

=======
    mapping(address => uint256) private s_addressToAmountFunded;
    address[] private s_funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    address private /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    AggregatorV3Interface private s_priceFeed;
    
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

<<<<<<< HEAD
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
=======
    function fund() public payable {
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }
    
    function getVersion() public view returns (uint256){
        return s_priceFeed.version();
    }
    
    modifier onlyOwner {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
    }

    function cheaperWithdraw() public onlyOwner {
        uint256 fundersLength = s_funders.length;
<<<<<<< HEAD
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
=======

        for(uint256 funderIndex = 0; funderIndex < fundersLength; funderIndex++) {
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    
    function withdraw() public onlyOwner {
        for (uint256 funderIndex=0; funderIndex < s_funders.length; funderIndex++){
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    /**
     * View/Pure function (getters)
     */

    function getAddressToAmountFunded(address fundingAddress) external view returns (uint256) {
        return s_addressToAmountFunded[fundingAddress];
    } 

    function getFunder(uint256 index) external view returns(address) {
        return s_funders[index];
    }

    function getOwner() external view returns(address) {
        return i_owner;
    }
}

>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
