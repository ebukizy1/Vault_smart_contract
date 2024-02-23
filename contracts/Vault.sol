// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract VaultSmartContract{


    uint public myCurrentTime;

    mapping(address => mapping(address => Beneficary)) public vaultBeneficiary;

    
    uint benecificaryID; 

    struct Beneficary{
        uint id;
        uint amount;
        
        uint lockedTime;
    }

    

function depositEthers(address beneficiary, uint _duration) external payable  {
    uint _id = benecificaryID + 1;
    uint _lockedTime = _duration + block.timestamp;
    
    require(msg.sender != address(0), "address zero not supported");
    require(msg.value > 0, "amount must be greater than zero");
    require(block.timestamp < _lockedTime, "locked time must be greater than current time");

    vaultBeneficiary[msg.sender][beneficiary] = Beneficary({
        id: _id,
        amount: msg.value,
        lockedTime: _lockedTime
    });

   benecificaryID += 1;
}



    function claimVaultMoney(address sender) external {
        require(sender != address(0), "inValid address");
        require(vaultBeneficiary[sender][msg.sender].id != 0, "address dont have saving");
        require(vaultBeneficiary[sender][msg.sender].lockedTime <=  block.timestamp, "you are not allowed remove money");
        uint _amountSaved = vaultBeneficiary[sender][msg.sender].amount;
        payable(msg.sender).transfer(_amountSaved);

    }

    function blockTime() external view returns(uint){
        return  block.timestamp;
    }
    
 





}