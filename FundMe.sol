// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 public minimumUSD = 5e18; // Minimum funding amount in USD (in wei)
    address[] public funders;
    mapping(address => uint256) public amountFundedPerAddress;

    // Function to receive funds from users
    function fund() public payable {
        // Ensure the minimum amount of ETH (in USD) is sent
        require(msg.value.getConversionRate() >= minimumUSD, "You need to send more ETH");

        funders.push(msg.sender);
        amountFundedPerAddress[msg.sender] += msg.value;
    }

   
}
