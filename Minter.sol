pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import './KJOS.sol';

contract Minter is Ownable {
    Klaytn17 private asset;
    Klaytn17 private newAsset;
    event Information(uint256 assetId, string tokenURI);
    event MintNew(uint256 assetId, string tokenURI);
    event ReturnOwnership(address owner);
    
    struct Detail {
        uint256 index;
        string uri;
    }
    
    Detail[] private data;
    uint256 private arrayIndex = 0;
    uint256 private startTime = 1634986700;
    uint256 private mintPrice = 33000000000000000000;
    
    function MintJoseonDynasty(address newAssetAddress) public payable returns (bool) {
        require(now >= startTime);
        require(data.length != 0);
        require(msg.value >= mintPrice);

        newAsset = Klaytn17(newAssetAddress);
        newAsset.mintWithTokenURI(msg.sender, data[arrayIndex].index, data[arrayIndex].uri);
        emit MintNew(data[0].index, data[arrayIndex].uri);

        arrayIndex++;

        return true;
    }

    function getIndexCursor() public view returns (uint256) {
        return arrayIndex;
    }
    
    function addData(uint256 _index, string memory _uri) public onlyOwner returns (bool) {
        data.push(Detail(_index, _uri));
        
        return true;
    }
    
    function addDataBulk(Detail[] memory _bulkData) public onlyOwner returns (bool) {
        for (uint256 i = 0; i < _bulkData.length; i++) {
            data.push(_bulkData[i]);
        }
        return true;
    }
    
    function getLeftTime() public view returns (uint256){
        return startTime - now;
    }
    
    function getLeftAmount() public view returns (uint256) {
        return data.length - arrayIndex;
    }
    
    function setStartTime(uint256 _time) public onlyOwner returns (bool) {
        startTime = _time;
        return true;
    }
    
    function setPrice(uint256 _price) public onlyOwner returns (bool) {
        mintPrice = _price;
        return true;
    }
    
    function getIndex(uint256 _index) public view onlyOwner returns (uint256) {
        return data[_index].index;
    }
    
    function getUri(uint256 _index) public view onlyOwner returns (string memory) {
        return data[_index].uri;
    }
    
    function claimBalance(uint256 amount) public onlyOwner returns (bool) {
        msg.sender.transfer(amount);
        return true;
    }
}
