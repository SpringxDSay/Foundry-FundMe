// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
<<<<<<< HEAD
    address USER = makeAddr("user");
    uint256 constant VALUE_SENT = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: VALUE_SENT}();
        _;
    }

=======

    address USER = makeAddr('user');
    uint256 constant SEND_VALUE = 0.1 ether; // 10000000000000000
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

<<<<<<< HEAD
    function testMinimumUsdIsFive() public view {
        console.log(fundMe.MINIMUM_USD());
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public view {
        console.log(uint256(fundMe.getVersion()));
        assertEq(uint256(fundMe.getVersion()), 4);
    }

    function testFailsWithoutEnoughEthSent() public {
        vm.expectRevert(); // The next line should fail
        fundMe.fund{value: 1e18}();
    }

    function testFundUpdatesFundedDataStructure() public funded {
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, VALUE_SENT);
    }

    function testAddFunderToFundersArray() public funded {
        address funder = fundMe.getFunder(0);
        assertEq(USER, funder);
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();
    }

    function testWithdrawalWithASingleFunder() public funded {
=======
    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMesgSender() public {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionAccuracy() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert(); // next line should revert
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public{
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithdrawWithASingleFunder() public funded {
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
        // Arrange
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        // Act
<<<<<<< HEAD
        vm.prank(fundMe.getOwner());
=======
        vm.prank(fundMe.getOwner()); // cost: 200
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
        fundMe.withdraw();

        // Assert
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;
        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMeBalance + startingOwnerBalance, endingOwnerBalance);
    }

<<<<<<< HEAD
    function testCheaperWithdrawalFromMultipleFunders() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingIndex = 1;
        for (uint160 i = startingIndex; i < numberOfFunders; i++) {
            // prank and deal together is hoax
            hoax(address(i), STARTING_BALANCE);
            fundMe.fund{value: VALUE_SENT}();
=======
    function testWithdrawFromMultipleFunders() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for(uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            // vm.prank new address
            // vm.deal new address
            // address()
            hoax(address(i), SEND_VALUE);
            // fund the fundMe
            fundMe.fund{value: SEND_VALUE}();      
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
        }
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        // Act
        vm.startPrank(fundMe.getOwner());
<<<<<<< HEAD
        fundMe.cheaperWithdraw();
        vm.stopPrank();

        // Assert
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
    }

    function testWithdrawalFromMultipleFunders() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingIndex = 1;
        for (uint160 i = startingIndex; i < numberOfFunders; i++) {
            // prank and deal together is hoax
            hoax(address(i), STARTING_BALANCE);
            fundMe.fund{value: VALUE_SENT}();
=======
        fundMe.withdraw();
        vm.stopPrank();   

        // Assert
        assert(address(fundMe).balance == 0);
        assert(startingOwnerBalance + startingFundMeBalance == fundMe.getOwner().balance);
    }

        function testWithdrawFromMultipleFundersCheaper() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for(uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            // vm.prank new address
            // vm.deal new address
            // address()
            hoax(address(i), SEND_VALUE);
            // fund the fundMe
            fundMe.fund{value: SEND_VALUE}();      
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
        }
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        // Act
        vm.startPrank(fundMe.getOwner());
<<<<<<< HEAD
        fundMe.withdraw();
        vm.stopPrank();

        // Assert
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
    }
}
=======
        fundMe.cheaperWithdraw();
        vm.stopPrank();   

        // Assert
        assert(address(fundMe).balance == 0);
        assert(startingOwnerBalance + startingFundMeBalance == fundMe.getOwner().balance);
    }
}

>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d
