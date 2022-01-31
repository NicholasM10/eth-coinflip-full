pragma solidity >=0.4.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CoinFlip {

    uint8 currentBetCount = 0;
    //0.1 eth by default
    uint128 betAmountInGwei = 100000000000000000;
    //Player addresses
    address playerOne;
    address playerTwo;

    function updateBetAmount(uint128 newBetAmount) external onlyOwner {
        betAmountInGwei = newBetAmount;
    }

    //Determine better's order and process the bet.
    function ProcessBet(address betAdress) public payable {
        if(currentBetCount == 0)
        {
            require(msg.value == betAmountInGwei);
            //
        }
    }

}