// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18; // Minimum funding amount in USD (in wei)
    address[] public funders;
    mapping(address => uint256) public amountFundedPerAddress;
      address public immutable i_owner;


    constructor() {
        i_owner = msg.sender;
    }

    // Function to receive funds from users
    function fund() public payable {
        // Ensure the minimum amount of ETH (in USD) is sent
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to send more ETH");

        funders.push(msg.sender);
        amountFundedPerAddress[msg.sender] += msg.value;
    }


    modifier onlyOwner() {
          if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    function withdraw() public onlyOwner{
         for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            amountFundedPerAddress[funder] = 0;
        }
        funders = new address[](0);

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
}
