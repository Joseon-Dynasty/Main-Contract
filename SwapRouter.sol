pragma solidity ^0.5.0;

import './KJOS.sol';

contract Swaper is Ownable {
    Klaytn17 private asset;
    Klaytn17 private newAsset;
    event Information(uint256 assetId, string tokenURI);
    event MintNew(uint256 assetId, string tokenURI);
    event ReturnOwnership(address owner);
    
    function SwapNft(address assetAddress, uint256 assetId, address newAssetAddress, uint256 index, string memory url) public returns (bool) {
        asset = Klaytn17(assetAddress);
        require(asset.ownerOf(assetId) == msg.sender);
        require(asset.isApprovedForAll(msg.sender, address(this)));
        
        emit Information(assetId, asset.tokenURI(assetId));
        
        asset.burnSingle(assetId);
        
        // burn finish & mint new
        newAsset = Klaytn17(newAssetAddress);
        newAsset.mintWithTokenURI(msg.sender, index, url);
        
        emit MintNew(index, url);

        return true;
    }
    
    function ReturnKjosOwnership(address assetAddress) public onlyOwner returns (bool) {
        asset = Klaytn17(assetAddress);
        require(asset.isOwner());
        asset.transferOwnership(owner());
        emit ReturnOwnership(owner());
        return true;
    }
}
