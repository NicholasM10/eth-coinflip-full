// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CoinFlip is Ownable {

    uint8 currentBetCount = 0;
    //0.1 eth by default
    uint128 betAmountInGwei = 100000000000000000;
    //Player addresses
    //Default is 0 = heads 1 = tails. Possible TO-DO: Make dynamic number of players.
    address[2] players;
    //Winner index
    uint8 winningPlayerIndex;

    function updateBetAmount(uint128 newBetAmount) external onlyOwner {
        betAmountInGwei = newBetAmount;
    }


    //Determine better's order and process the bet.
    function acceptBet() public payable {
        if(currentBetCount == 0)
        {
            require(msg.value == betAmountInGwei, "Incorrect Amount of ETH Received");

            players[currentBetCount] = msg.sender;
            currentBetCount++;
        } 
        else if(currentBetCount == 1)
        {
            require(msg.value == betAmountInGwei, "Incorrect Amount of ETH Received");
            
            players[currentBetCount] = msg.sender;
            currentBetCount++;
        }
        if(currentBetCount == 2)
        {
            processBet();
        }
    }

    function processBet() private {
        require(players[0] != address(0));
        require(players[1] != address(0));

        winningPlayerIndex = uint8(random());
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    } 

    function rewardWinner() public payable {
        payable(players[winningPlayerIndex]).transfer(betAmountInGwei * (players.length));
    }

}