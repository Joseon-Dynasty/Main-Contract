pragma solidity ^0.5.0;

import './KJOS.sol';

contract TicketSwaper is Ownable {
    Klaytn17 private asset;
    Klaytn17 private swapAsset;

    event SwapTicket(address asset, uint256 assetId);
    event ReturnOwnership(address owner);
    
    address[] private data;
    uint256 private index = 0;
    
    address private vault;
    
    function SwapNft(uint256 assetId) public returns (bool) {
        asset = Klaytn17(0xA66B04cEbd230f07da359a6420A4A38C120Df379);
        require(asset.ownerOf(assetId) == msg.sender);
        require(asset.isApprovedForAll(msg.sender, address(this)));
        
        asset.burnSingle(assetId);
        
        swapAsset = Klaytn17(data[index]);
        uint256 swapAssetIndex = swapAsset.tokenOfOwnerByIndex(vault, 0);
        swapAsset.transferFrom(vault, msg.sender, swapAssetIndex);
        
        emit SwapTicket(data[index], swapAssetIndex);
        index += 1;

        return true;
    }
    
    function addData(address _data) public onlyOwner returns (bool) {
        data.push(_data);
        
        return true;
    }
    
    function addDataBulk(address[] memory _bulkData) public onlyOwner returns (bool) {
        for (uint256 i = 0; i < _bulkData.length; i++) {
            data.push(_bulkData[i]);
        }
        return true;
    }
    
    function ReturnJostOwnership() public onlyOwner returns (bool) {
        asset = Klaytn17(0xA66B04cEbd230f07da359a6420A4A38C120Df379);

        require(asset.isOwner());
        asset.transferOwnership(owner());
        emit ReturnOwnership(owner());
        return true;
    }
    
    function getData(uint256 _index) public view onlyOwner returns (address) {
        return data[_index];
    }
    
    function setVault (address _vault) public onlyOwner returns (address) {
        vault = _vault;
        return vault;
    }
    
    function getVault() public view onlyOwner returns (address) {
        return vault;
    }
    
    function getDataLength() public view onlyOwner returns (uint256) {
        return data.length;
    }
    
    function getIndex() public view onlyOwner returns (uint256) {
        return index;
    }
}
