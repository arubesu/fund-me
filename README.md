

# Solidity Smart Contracts

This repository contains Solidity smart contracts for interacting with the Ethereum network. The primary contracts are `PriceConverter.sol` and `FundMe.sol`.

## PriceConverter.sol

### Description

The `PriceConverter` library provides functions to get the current price of ETH in USD and to convert an amount of ETH to USD.

### Functions

- **`getPrice()`**

  ```solidity
  function getPrice() internal view returns (uint256)
  ```

  Retrieves the current price of ETH in USD from the Chainlink price feed. The price is returned in 18 decimal places.

- **`getConversionRate(uint256 weiAmount)`**

  ```solidity
  function getConversionRate(uint256 weiAmount) internal view returns (uint256)
  ```

  Converts a given amount of ETH (in wei) to its USD equivalent (in wei) using the current ETH price.

### Dependencies

- **Chainlink Price Feed:** The contract uses the Chainlink Price Feed to get the ETH/USD price. The specific address used is `0x694AA1769357215DE4FAC081bf1f309aDC325306`.

## FundMe.sol

### Description

The `FundMe` contract allows users to fund the contract with ETH, ensures that the minimum funding amount in USD is met, and enables the contract owner to withdraw all funds.

### Functions

- **`fund()`**

  ```solidity
  function fund() public payable
  ```

  Receives ETH from users. Ensures that the amount sent meets or exceeds a minimum value specified in USD.

- **`withdraw()`**

  ```solidity
  function withdraw() public onlyOwner
  ```

  Allows the contract owner to withdraw all funds from the contract. Resets the funders list and clears the amounts funded by each address.

- **`fallback()`**

  ```solidity
  fallback() external payable
  ```

  Allows the contract to receive ETH sent to it directly and calls the `fund()` function.

- **`receive()`**

  ```solidity
  receive() external payable
  ```

  Allows the contract to receive ETH via the `receive()` function and calls the `fund()` function.

### Errors

- **`NotOwner()`**

  Custom error used to indicate that the caller is not the contract owner.

### Dependencies

- **`PriceConverter`:** The `FundMe` contract uses the `PriceConverter` library to convert ETH amounts to USD.

## How to Use

1. **Deploy `FundMe.sol`:** Deploy the `FundMe` contract to the Ethereum network.

2. **Fund the Contract:** Use the `fund()` function to send ETH to the contract. Ensure the amount meets the minimum USD value.

3. **Withdraw Funds:** The contract owner can call the `withdraw()` function to retrieve all funds.

4. **Receive ETH Directly:** ETH sent directly to the contract address will be processed by the `fallback()` or `receive()` functions.

### Reference 
This project is part of the course available at [https://updraft.cyfrin.io/].
