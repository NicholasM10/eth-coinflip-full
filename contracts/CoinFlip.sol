// SPDX-License-Identifier: MIT
pragma solidity >=0.4.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CoinFlip is Ownable {

    uint8 currentBetCount = 0;
    //0.1 eth by default
    uint128 betAmountInGwei = 100000000000000000;
    //Player addresses
    address playerHeads;
    address playerTails;
    //Winner index
    uint8 winningPlayerIndex;
    //Contract Owner
    address owner;

    constructor() {
        owner = msg.sender; // setting the contract creator
    }

    function updateBetAmount(uint128 newBetAmount) external onlyOwner {
        betAmountInGwei = newBetAmount;
    }

    //Determine better's order and process the bet.
    function acceptBet() public {
        if(currentBetCount == 0)
        {
            require(msg.value == betAmountInGwei);
            //
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
            processBet();
        }
    }

    function processBet() internal payable {
        require(playerHeads != 0);
        require(playerTails != 0);

        winningPlayerIndex = random() % 2;
    }

    function random() private view returns (uint) {
        //Convert hash to integer
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, 2)));
    }

    function rewardWinner() internal payable 
    {

    }

}