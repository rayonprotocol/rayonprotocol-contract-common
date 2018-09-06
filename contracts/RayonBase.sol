pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/ownership/Claimable.sol";
import "openzeppelin-solidity/contracts/ownership/HasNoContracts.sol";
import "openzeppelin-solidity/contracts/ownership/HasNoEther.sol";

contract RayonBase is Claimable, HasNoContracts, HasNoEther {
    string internal name;
    uint16 internal version;

    constructor(string _name, uint16 _version) public {
        name = _name;
        version = _version;
    }

    function getName() public view returns(string){
        return name;
    }

    function getVersion() public view returns(uint16){
        return version;
    }

    function claimOwnershipContract(address _contractAddr) public onlyOwner {
        require(_contractAddr != address(0), "contract address cannot be 0x0");
        Claimable contractInst = Claimable(_contractAddr);
        contractInst.claimOwnership();
    }

    function reclaimOwnershipContract(address _contractAddr) public onlyOwner {
        require(_contractAddr != address(0), "contract address cannot be 0x0");
        Ownable _contractInst = Ownable(_contractAddr);
        _contractInst.transferOwnership(owner);
    }

    function kill() external onlyOwner {
        selfdestruct(owner);
    }
}