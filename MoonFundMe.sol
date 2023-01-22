//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract MoonFundMe{
    //personas que fondearan el contrato y la cantidad
    mapping (address => uint256) public AddressToAmountFounded;
    address [] public founders;//array para saber quienes fueron los foundesrs del contrato
    address public owner;//variable que almacena al dueño
    constructor(){
        owner=msg.sender;//quien ejecute el contrato sera el dueño
    }
    function found()public payable{
       uint256 minDev=0.5 * 10**18;
       require(msg.value>=minDev,"Necesitas mas DEV");
       AddressToAmountFounded[msg.sender] += msg.value;
       founders.push(msg.sender);
    }
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    function withdraw() payable onlyOwner public{
      payable(msg.sender).transfer(address(this).balance);
      for(uint256 founderIndex;founderIndex<founders.length;founderIndex++){
          address funder=founders[founderIndex];
          AddressToAmountFounded[funder]=0;
      }
      founders=new address[](0);
    }

}