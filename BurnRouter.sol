pragma solidity ^0.5.0;

import './KJOS.sol';

contract Burner is Ownable {
    Klaytn17 private asset;
    event Information(uint256 assetId, string tokenURI);
    event ReturnOwnership(address owner);
    
    function BurnKjos(address assetAddress, uint256 assetId) public returns (bool) {
        asset = Klaytn17(assetAddress);
        require(asset.ownerOf(assetId) == msg.sender);
        require(asset.isApprovedForAll(msg.sender, address(this)));
        
        emit Information(assetId, asset.tokenURI(assetId));
        
        asset.burnSingle(assetId);

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
