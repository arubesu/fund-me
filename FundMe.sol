// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUSD = 5e18; // Minimum funding amount in USD (in wei)
    address[] public funders;
    mapping(address => uint256) public amountFundedPerAddress;

    // Function to receive funds from users
    function fund() public payable {
        // Ensure the minimum amount of ETH (in USD) is sent
        require(getConversionRate(msg.value) >= minimumUSD, "You need to send more ETH");

        funders.push(msg.sender);
        amountFundedPerAddress[msg.sender] += msg.value;
    }

    // Function to withdraw funds
    function withdraw() public {
        // Withdrawal logic to be implemented
    }

    // Function to get the current price of ETH in USD (in wei)
    function getPrice() public view returns (uint256) {
        // Chainlink Price Feed address for ETH/USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        (
            ,
            int256 price,
            ,
            ,
            
        ) = priceFeed.latestRoundData();

        // The price feed returns price in 8 decimal places, so convert it to 18 decimal places
        return uint256(price * 1e10);
    }

    // Function to convert ETH amount to USD (in wei)
    function getConversionRate(uint256 weiAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * weiAmount) / 1e18;

        return ethAmountInUSD;
    }
}
