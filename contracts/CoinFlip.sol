// SPDX-License-Identifier: MIT
pragma solidity >=0.4.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CoinFlip {

    uint8 currentBetCount = 0;
    //0.1 eth by default
    uint128 betAmountInGwei = 100000000000000000;
    //Player addresses
    address playerHeads;
    address playerTails;

    constructor() {
        owner = payable(msg.sender); // setting the contract creator
    }

    function updateBetAmount(uint128 newBetAmount) external onlyOwner {
        betAmountInGwei = newBetAmount;
    }

    //Determine better's order and process the bet.
    function AcceptBet() public {
        if(currentBetCount == 0)
        {
            require(msg.value == betAmountInGwei);
            playerHeads = msg.sender;
            currentBetCount++;
        } 
        else if(currentBetCount == 1)
        {
            require(msg.value == betAmountInGwei);
            playerTails = msg.sender;
            currentBetCount++;
        }
        if(currentBetCount == 2)
        {
            ProcessBet();
        }
    }

    function ProcessBet() internal payable {
        require(playerHeads != 0);
        require(playerTails != 0);
        
    }

}