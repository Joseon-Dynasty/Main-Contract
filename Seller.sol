pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import './KJOS.sol';

contract Seller is Ownable {
    Klaytn17 private newAsset;
    event Information(uint256 assetId, string tokenURI);
    event ReturnOwnership(address owner);
    
    uint256 private arrayIndex = 5601;
    uint256 private startTime = 1634986700;
    uint256 private mintPrice = 33000000000000000000;
    
    function SellToken() public payable returns (bool) {
        require(now >= startTime);
        require(msg.value >= mintPrice);
        require(arrayIndex < 9000);

        // newAsset = Klaytn17(0xCE8905B85119928E6c828E5CB4E2a9fd2e128bf9);
        // newAsset.transferFrom(0x893FaF652114F82250Dfca9047e5334c93606f5F, msg.sender, arrayIndex);

        newAsset = Klaytn17(0x931B745C67C6f0d6B0D4080F8142aAa6D8316f41);
        newAsset.transferFrom(0x52342bB4D046E13e3de377D5f1D076681c096FF4, msg.sender, arrayIndex);

        arrayIndex++;

        return true;
    }

    function getIndexCursor() public view returns (uint256) {
        return arrayIndex;
    }
    
    function getLeftTime() public view returns (uint256){
        return startTime - now;
    }
    
    function getLeftAmount() public view returns (uint256) {
        return 9000 - arrayIndex;
    }
    
    function setStartTime(uint256 _time) public onlyOwner returns (bool) {
        startTime = _time;
        return true;
    }
    
    function setPrice(uint256 _price) public onlyOwner returns (bool) {
        mintPrice = _price;
        return true;
    }
    
    function claimBalance(uint256 amount) public onlyOwner returns (bool) {
        msg.sender.transfer(amount);
        return true;
    }
}
