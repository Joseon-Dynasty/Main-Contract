pragma solidity ^0.5.0;

import './KJOS.sol';

contract Burner is Ownable {
    Klaytn17 private asset;
    event Information(uint256 assetId, string tokenURI);
    event ReturnOwnership(address owner);
    
    function BurnKjos(uint256 assetId) public returns (bool) {
        asset = Klaytn17(0x53dfc10674fd84605840884d7d021287f098c2af);
        require(asset.ownerOf(assetId) == msg.sender);
        require(asset.isApprovedForAll(msg.sender, address(this)));
        
        emit Information(assetId, asset.tokenURI(assetId));
        
        asset.burnSingle(assetId);

        return true;
    }
    
    function ReturnKjosOwnership() public onlyOwner returns (bool) {
        asset = Klaytn17(0x53dfc10674fd84605840884d7d021287f098c2af);
        require(asset.isOwner());
        asset.transferOwnership(owner());
        emit ReturnOwnership(owner());
        return true;
    }
}
