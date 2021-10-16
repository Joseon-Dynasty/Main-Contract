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
    uint256 private startTime = 1634468400;
    uint256 private mintPrice = 20000000000000000000;
    
    function _deleteElement(uint256 _index) private {
        if (data.length != 1) {
            for (uint256 i = _index; i < data.length - 1; i++) {
              data[i] = data[i + 1];
            }
        }
        delete data[data.length - 1];
        data.length--;
    }
    
    function MintJoseonDynasty(address newAssetAddress) public payable returns (bool) {
        require(now >= startTime);
        require(data.length != 0);
        require(msg.value >= mintPrice);

        newAsset = Klaytn17(newAssetAddress);
        newAsset.mintWithTokenURI(msg.sender, data[0].index, data[0].uri);
        emit MintNew(data[0].index, data[0].uri);
        _deleteElement(0);

        return true;
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
        return data.length;
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
